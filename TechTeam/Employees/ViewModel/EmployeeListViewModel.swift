//
//  EmployeeListViewModel.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 07/02/2021.
//

import Foundation
import RxSwift
import RxCocoa

class EmployeeListViewModel {
    
    var finishedFetching: PublishSubject<Bool> = PublishSubject()
    var errorOnFetchData: PublishSubject<APIManager.RequestError> = PublishSubject()
    
    let disposeBag = DisposeBag()
    
    private var employeesViewModel: [EmployeeViewModel]
    
    private var isLoadingData: Bool = false
    
    var reloadDataAvailable: Bool {
        return numberOfItemsInSection() == 0 && !isLoadingData
    }
    
    init(_ employees: [Employee]) {
        self.employeesViewModel = employees.compactMap(EmployeeViewModel.init)
    }

    /// fetch data and trigger subscribers for provided data/error
    func fetchData() {
        isLoadingData = true
        
        if let url =  URL(string: APIManager.getResource2(type: .getBaseDescription)) {
            let resource = Resource2<[Employee]>(url: url)
            print(resource.url)
            URLRequest.load(resource: resource)
//                .retry(2)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    print(response)
                    
                    
//                    self.noticeView.animateView(show: false)
//                    let photos = response.photos.photo
//                    self.photoListViewModel?.append(photos)
//                    self.collectionView.reloadData()
//                    self.isPageRefreshing = false
                }, onError: { (error) in
                    print("Tu --- ", error.localizedDescription)
//                    self.noticeView.animateView(show: true)
                }).disposed(by: disposeBag)
        }

            
        APIManager.requestData(endpointType: .getBaseDescription, decodeType: [Employee].self) { [weak self] (result) in
            self?.isLoadingData = false
            switch result {
            case .success(let returnModel) :
                    let employees = returnModel
                    self?.employeesViewModel = employees.compactMap(EmployeeViewModel.init)
                    self?.finishedFetching.onNext(true)
            case .failure(let failure) :
                switch failure {
                case .connectionError:
                    self?.errorOnFetchData.onNext(APIManager.RequestError.connectionError)
                case .authorizationError:
                    self?.errorOnFetchData.onNext(APIManager.RequestError.authorizationError)
                default:
                    self?.errorOnFetchData.onNext(APIManager.RequestError.unknownError)
                }
            }
        }
    }
    
    func simpleGetUrlRequest()
        {
        if let url =  URL(string: APIManager.getResource2(type: .getBaseDescription)) {

        let resource = Resource2<[Employee]>(url: url)

            let url = resource.url

            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                print("The response is : ",String(data: data, encoding: .utf8)!)
                //print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) as Any)
            }
            task.resume()
        }
        }

    /// get number of sections
    func numberOfItemsInSection() -> Int {
        return employeesViewModel.count
    }
    
    /// employee at specific index
    func getEmployeeAt(_ index: Int) -> EmployeeViewModel {
        return employeesViewModel[index]
    }

}
