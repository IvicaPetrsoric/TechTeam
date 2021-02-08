//
//  EmployeesViewController.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 05/02/2021.
//

import UIKit
import RxSwift
import RxCocoa

class EmployeesCollectionViewController: UICollectionViewController {
    
    private(set) var employeeListViewModel = EmployeeListViewModel([])
    private let refreshControl = UIRefreshControl()

    let cellId = "cellId"
    let headerCellId = "headerCellId"

    let disposeBag = DisposeBag()
    let progressIndicatorView = PrgoressIndicator()

    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Employees"
        collectionView.backgroundColor = .backgroundColor
        
        registerHeaderCell()
        registerCell()
        setupProgressIndicatorView()
        setupRefreshControl()
   }
    
    private func setupProgressIndicatorView() {
        view.addSubview(progressIndicatorView)
        progressIndicatorView.anchorFillSuperview()
    }
    
    private func setupRefreshControl() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.primaryColor
        collectionView.refreshControl = refreshControl
    }

    @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        if employeeListViewModel.numberOfItemsInSection() == 0 {
            self.progressIndicatorView.animate(show: true)
            self.fetchData()
        }
    }

    func fetchData() {
        if let url =  URL(string: "https://teltech.co/teltechiansFlat.json"){
            let resource = Resource<[Employee]>(url: url)
            
            URLRequest.load(resource: resource)
                .retry(2)
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { response in
                    let employees = response
//                    return
                    self.employeeListViewModel = EmployeeListViewModel(employees)
                    
                    self.employeeListViewModel
                        .selectedPhoto
                        .observe(on: MainScheduler.instance)
                        .subscribe(onNext: { value in
                            print("TU SAM")
                            if value {
                                self.progressIndicatorView.animate(show: false)
                            }
                        })
                        .disposed(by: self.disposeBag)
                    self.collectionView.reloadData()
                }, onError: { (_) in
//                    self.noticeView.animateView(show: true)
                }).disposed(by: disposeBag)
        }
    }
    
}
