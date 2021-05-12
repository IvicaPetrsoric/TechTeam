//
//  EmployeeFooterCell.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 12/05/2021.
//

import UIKit

class EmployeeFooterCell: BaseCollectionReusableView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .primaryColor
        activity.startAnimating()
        return activity
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading more..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .primaryColor
        return label
    }()
    
    override func setupViews() {
        let stackView = VerticalStackView(arrangedSubviews: [
            activityIndicator, infoLabel
            ], spacing: 24)
        stackView.alignment = .center
            
        addSubview(stackView)
        stackView.anchorCenterSuperview(size: .init(width: 200, height: 0))
    }
    
}
