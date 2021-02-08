//
//  OnboardingCollectionViewController+CollectionView.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 08/02/2021.
//

import UIKit

extension OnboardingCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        collectionView.backgroundColor = .backgroundColor
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(OnboardingPageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let index = Int(x / view.frame.width)
        handleUpdatePageController(at: index, aniamteCollection: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingPageListViewModel.numberOfItemsInSection()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OnboardingPageCell
        let index = indexPath.item
        let viewModel = onboardingPageListViewModel.getPageDataAt(index)
        
        viewModel.pageImage.asDriver(onErrorJustReturn: #imageLiteral(resourceName: "ic_launch"))
            .drive(cell.avatarImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.pageTitle.asDriver(onErrorJustReturn: "Title")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.pageDescription.asDriver(onErrorJustReturn: "Description")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
        
}
