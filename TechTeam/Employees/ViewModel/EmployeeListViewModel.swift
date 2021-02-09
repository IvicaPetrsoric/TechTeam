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

    func fetchData() {
        isLoadingData = true
            
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

    /// get number of sections
    func numberOfItemsInSection() -> Int {
        return employeesViewModel.count
    }
    
    /// page at specific index
    func getEmployeeAt(_ index: Int) -> EmployeeViewModel {
        return employeesViewModel[index]
    }

}
