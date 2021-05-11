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
    
    private let disposeBag = DisposeBag()
    
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
        
        if let url =  URL(string: APIManager.getResource(type: .getBaseDescription)) {
            let resource = Resource<[Employee]>(url: url)

            URLRequest.loadJSON(resource: resource)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { data in
                    self.isLoadingData = false

                    switch data {
                    case .success(let returnModel) :
                        let employees = returnModel
                            self.employeesViewModel = employees.compactMap(EmployeeViewModel.init)
                            self.finishedFetching.onNext(true)
                    case .failure(let failure):
                        switch failure {
                        case .connectionError:
                            self.errorOnFetchData.onNext(APIManager.RequestError.connectionError)
                        case .authorizationError:
                            self.errorOnFetchData.onNext(APIManager.RequestError.authorizationError)
                        default:
                            self.errorOnFetchData.onNext(APIManager.RequestError.unknownError)
                        }
                    }
                }
            ).disposed(by: disposeBag)
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
