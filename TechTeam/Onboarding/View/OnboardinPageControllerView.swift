//
//  OnboardinPageControllerView.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 05/02/2021.
//

import UIKit

class OnboardinPageControllerView: UIView {
    
    private var onboardingPageListViewModel = OnboardingPageListViewModel([])
    
    lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("PageControllerPrevButtontTetxt", comment: ""), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.primaryColor, for: .normal)
        button.setTitleColor(.activeColor, for: .disabled)
        button.isEnabled = false
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPage = 0
        pageController.numberOfPages = onboardingPageListViewModel.numberOfItemsInSection()
        pageController.currentPageIndicatorTintColor = .primaryColor
        pageController.pageIndicatorTintColor = .activeColor
        pageController.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("PageControllerNextButtontTetxt", comment: ""), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.primaryColor, for: .normal)
        button.setTitleColor(.activeColor, for: .disabled)
        return button
    }()
    
    lazy var eploreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("PageControllerExploreButtontTetxt", comment: ""), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .primaryColor
        button.layer.cornerRadius = 6
        button.alpha = 0
        return button
    }()

    init(viewModel: OnboardingPageListViewModel) {
        self.onboardingPageListViewModel = viewModel
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.distribution = .fill
                
        addSubview(bottomControlsStackView)
        
        bottomControlsStackView.anchorCenterXToSuperview()
        bottomControlsStackView.anchor(top: topAnchor, leading: nil,bottom: bottomAnchor, trailing: nil,
                                       size: .init(width: 320, height: 0))
                
        previousButton.anchorConstraintWidth(constant: 66)
        nextButton.anchorConstraintWidth(constant: 66)
        
        addSubview(eploreButton)
        
        eploreButton.anchorCenterXToSuperview()
        eploreButton.anchor(top: bottomControlsStackView.topAnchor, leading: nil,
                            bottom: bottomControlsStackView.bottomAnchor, trailing: nil,
                            size: .init(width: 128, height: 0))
        
        animateExploreButton(show: false)
    }
    
    /// set new position to page controller
    func updateControllerPosition(index: Int) {
        pageControl.currentPage = index
        updateViews()
    }
    
    /// update if prev/next button is available, if on last card show button for transition
    private func updateViews() {
        if pageControl.currentPage == 0 {
            previousButton.isEnabled = false
            nextButton.isEnabled = true
        } else if pageControl.currentPage == onboardingPageListViewModel.numberOfItemsInSection() - 1 {
            previousButton.isEnabled = true
            nextButton.isEnabled = false
            animateExploreButton(show: true)
        } else {
            previousButton.isEnabled = true
            nextButton.isEnabled = true
            animateExploreButton(show: false)
        }
    }
    
    /// shows/hide explore button from the screen
    private func animateExploreButton(show: Bool) {
        let transform = show ? .identity : CGAffineTransform(translationX: 0, y: 200)

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.eploreButton.transform = transform
            self.eploreButton.alpha = show ? 1 : 0
        })
    }
    
}
