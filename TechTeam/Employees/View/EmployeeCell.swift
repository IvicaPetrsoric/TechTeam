//
//  EmployeeCell.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 08/02/2021.
//

import UIKit

class EmployeeCell: BaseCollectionCell {
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1,
                           options: .curveEaseOut, animations: {
                            self.transform = self.isHighlighted ? .init(scaleX: 0.9, y: 0.9) : .identity
            })
        }
    }
      
    private lazy var containerView: UIView = {
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
