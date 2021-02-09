//
//  EmployeeHeaderCell.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 08/02/2021.
//

import UIKit

class EmployeeHeaderCell: BaseCollectionCell {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_search")
        imageView.tintColor = .primaryColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Welcome to the Employee page.\nIf no Employees shown please pull down on the page!",
                                       comment: "")
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
