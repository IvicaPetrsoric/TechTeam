//
//  EmployeesViewController.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 05/02/2021.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI

class EmployeesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let disposeBag = DisposeBag()
    
    private var employeeListViewModel = EmployeeListViewModel([])

    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ic_launch").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cellId = "cellId"
    private let headerCellId = "headerCellId"
       
    var progressIndicatorView = PrgoressIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Employees"
        collectionView.bounces = true

        collectionView.backgroundColor = .backgroundColor
        
        collectionView.register(EmployeeHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        collectionView.register(EmployeeCell.self, forCellWithReuseIdentifier: cellId)
       
                view.addSubview(progressIndicatorView)
                progressIndicatorView.anchorFillSuperview()

        delay(2) {
//            self.progressIndicatorView.animate(show: true)
//            self.fetchData()
        }
//        fetchData()
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
          refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.primaryColor
        self.collectionView.refreshControl = refreshControl

       }

       @objc func refresh(_ sender: AnyObject) {
        refreshControl.endRefreshing()
        if employeeListViewModel.numberOfItemsInSection() == 0 {
            self.progressIndicatorView.animate(show: true)
            self.fetchData()
        }

          // Code to refresh table view
       }
    let refreshControl = UIRefreshControl()


//    var refreshControl = UIRefreshControl()
    
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return employeeListViewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EmployeeCell
        let index = indexPath.item
        
        
        let viewModel = employeeListViewModel.getEmployeeAt(index)
        
        viewModel.title.asDriver(onErrorJustReturn: NSMutableAttributedString())
            .drive(cell.titleLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.imageUrl.asDriver(onErrorJustReturn: UIImage())
            .drive(cell.avatarImageView.rx.image)
            .disposed(by: disposeBag)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let viewModel = employeeListViewModel.getEmployeeAt(index)
        let hostingViewController = EmployeeDetailsViewHostingController(viewModel: viewModel)
        hostingViewController.modalPresentationStyle = .overCurrentContext

        present(hostingViewController, animated: true)

        print("Selected \(index)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath)
            return header
        } else {
            fatalError("Error with footer/header cell, on kind\(kind)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = employeeListViewModel.numberOfItemsInSection() > 0 ? 0 : collectionView.frame.width * 1.5
        return .init(width: collectionView.frame.width, height: height)
    }
        
}


class EmployeeDetailsViewHostingController: UIHostingController<EmployeeDetailsView> {
    
    init(viewModel: EmployeeViewModel) {
        super.init(rootView: EmployeeDetailsView(employeeViewModel: viewModel))
        rootView.dismiss = dismiss
        
        view.backgroundColor = .clear
        view.isOpaque = false
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismiss() {
        rootView.dismiss = nil
        dismiss(animated: true) {
            self.removeFromParent()
            self.view.removeFromSuperview()
            
        }
    }
}

class EmployeeHeaderCell: BaseCollectionCell {
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_search")
        imageView.tintColor = .primaryColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Employees.\nIf no employees shown please drag down to activate fetch :)"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    override func setupViews() {
        addSubviews(avatarImageView, infoLabel)
        
        avatarImageView.anchorCenterSuperview(size: .init(width: 80, height: 80), constantY: -90)
        infoLabel.anchorFillSuperview()
    }
    
}

class EmployeeCell: BaseCollectionCell {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,
                           options: .curveEaseOut, animations: {
                            self.transform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
            })
        }
    }
      
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .activeColor
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor(white: 0.7, alpha: 0.7).cgColor
        return view
    }()

    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ic_launch"))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .inactiveColor
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TITLE\nTitle"
        label.numberOfLines = 0

        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    override func setupViews() {
        addSubviews(containerView)
        containerView.anchorFillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
        
        containerView.addSubviews(avatarImageView, titleLabel)
        
        avatarImageView.anchorCenterSuperview(size: .init(width: 90, height: 90), constantY: -16)
                
        titleLabel.anchor(top: avatarImageView.bottomAnchor, leading: containerView.leadingAnchor,
                          bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor,
                          padding: .init(top: 0, left: 4, bottom: 0, right: 4))
    }
    
}

public extension UIImageView {
    func loadImage(fromURL url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let cache =  URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
    func transition(toImage image: UIImage?) {
        UIView.transition(with: self, duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.image = image
        },
                          completion: nil)
    }
}
