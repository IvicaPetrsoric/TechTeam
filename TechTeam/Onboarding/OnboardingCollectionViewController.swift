//
//  OnboardingViewController.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 05/02/2021.
//

import UIKit
import RxCocoa
import RxSwift

class OnboardingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var onboardingPageListViewModel = OnboardingPageListViewModel([])
    
    private var currentPageIndex = 0
    
    private lazy var onboardinPageControllerView = OnboardinPageControllerView(viewModel: onboardingPageListViewModel)
       
    private let cellId = "cellId"
    
    private let disposeBag = DisposeBag()

    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let index = Int(x / view.frame.width)
        handleUpdatePageController(at: index, aniamteCollection: false)
    }
    
    private func handleUpdatePageController(at index: Int, aniamteCollection: Bool) {
        currentPageIndex = index
        onboardinPageControllerView.updateControllerPosition(index: currentPageIndex)
        
        if aniamteCollection {
            let indexPath = IndexPath(item: currentPageIndex, section: 0)
            collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    init(pagesData: [OnboardingPage]) {
        onboardingPageListViewModel = OnboardingPageListViewModel(pagesData)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView.backgroundColor = .backgroundColor
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
                
        view.addSubviews(onboardinPageControllerView)
        
        onboardinPageControllerView.anchor(top: nil, leading: view.leadingAnchor,
                                           bottom: view.safeBottomAnchor, trailing: view.trailingAnchor,
                                           padding: .init(top: 0, left: 4, bottom: 66, right: 4),
                                           size: .init(width: 0, height: 50))
        
        setupOnboardingViewTapBindings()
    }
    
    func setupOnboardingViewTapBindings() {
        onboardinPageControllerView.previousButton.rx.tap.bind { [weak self] in
            self?.handlePrev()
        }.disposed(by: disposeBag)
        
        onboardinPageControllerView.nextButton.rx.tap.bind { [weak self] in
            self?.handleNext()
        }.disposed(by: disposeBag)
        
        onboardinPageControllerView.eploreButton.rx.tap.bind { [weak self] in
            self?.handleExplore()
        }.disposed(by: disposeBag)
    }
    
    private func handlePrev(){
        let nextIndex = max(currentPageIndex - 1, 0)
        handleUpdatePageController(at: nextIndex, aniamteCollection: true)
    }
        
    private func handleNext(){
        let nextIndex = min(currentPageIndex + 1, onboardingPageListViewModel.numberOfItemsInSection())
        handleUpdatePageController(at: nextIndex, aniamteCollection: true)
    }
    
    private func handleExplore() {
        print("Explor Team")
    }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingPageListViewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! OnboardingCell
        let index = indexPath.item
        cell.pageData = onboardingPageListViewModel.getPageDataAt(index)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}





