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

        navigationItem.title = NSLocalizedString("EmlpoyeesNagiationTitle", comment: "")
        collectionView.backgroundColor = .backgroundColor
        
        registerHeaderCell()
        registerCell()
        setupProgressIndicatorView()
        setupRefreshControl()
        
        employeeListViewModel.fetchData()
        setupBindings()
   }
    
    private func setupProgressIndicatorView() {
        view.addSubview(progressIndicatorView)
        progressIndicatorView.anchorFillSuperview()
    }
    
    private func setupRefreshControl() {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("EmployeePullRefreshTitle", comment: ""), attributes: attributes)
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.primaryColor
        collectionView.refreshControl = refreshControl
    }

    @objc private func handlePullToRefresh() {
        refreshControl.endRefreshing()
      
        if employeeListViewModel.reloadDataAvailable {
            progressIndicatorView.animate(show: true)
            employeeListViewModel.fetchData()
        }
    }
    
    private func setupBindings() {
        employeeListViewModel
            .finishedFetching
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                if value {
                    self?.progressIndicatorView.animate(show: false)
                    self?.collectionView.reloadData()
                }
            })
            .disposed(by: self.disposeBag)
        
        employeeListViewModel
            .errorOnFetchData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (error) in
                self?.progressIndicatorView.animate(show: false)

                switch error {
                case .connectionError:
                    self?.showAllert(message: .errorConnection)
                default:
                    //TODO:- implement switch for handling other errors
                    self?.showAllert(message: .errorConnection)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
