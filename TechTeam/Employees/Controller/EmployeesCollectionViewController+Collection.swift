//
//  EmployeesCollectionViewController+Collection.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 08/02/2021.
//

import UIKit

extension EmployeesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func registerCell() {
        collectionView.register(EmployeeCell.self, forCellWithReuseIdentifier: cellId)
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
        present(hostingViewController, animated: true)
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
    
    
}
