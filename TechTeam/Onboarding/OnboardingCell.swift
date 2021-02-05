//
//  OnboardingCell.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 05/02/2021.
//

import UIKit

class OnboardingCell: BaseCollectionCell {
    
    var pageData: OnboardingPage? {
        didSet {
            guard let pageData = pageData else { return }
            
            let description = "\"\(pageData.description)\""
            descriptionLabel.text = description
            avatarImageView.image = UIImage(named: pageData.imageName)?.withRenderingMode(.alwaysTemplate)
            titleLabel.text = pageData.title
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
    
    private lazy var avatarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .inactiveColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 90
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        return view

    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "ic_launch"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .primaryColor
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TITLE"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "DESCRIPTION"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(white: 0.8, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    override func setupViews() {
        addSubviews(containerView)
        containerView.anchorCenterSuperview(size: .init(width: 320, height: 444))
        
        containerView.addSubviews(avatarContainerView, titleLabel, descriptionLabel)
        
        avatarContainerView.anchorCenterSuperview(size: .init(width: 180, height: 180), constantY: -90)
        
        avatarContainerView.addSubview(avatarImageView)
        avatarImageView.anchorFillSuperview(padding: .init(top: 32, left: 32, bottom: 32, right: 32))
        
        titleLabel.anchor(top: avatarContainerView.bottomAnchor, leading: containerView.leadingAnchor,
                          bottom: nil, trailing: containerView.trailingAnchor,
                          padding: .init(top: 44, left: 16, bottom: 0, right: 16))

        descriptionLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor,
                                bottom: containerView.bottomAnchor, trailing: titleLabel.trailingAnchor,
                                padding: .init(top: 4, left: 0, bottom: 32, right: 0))
    }
    
}
