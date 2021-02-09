//
//  PrgoressIndicator.swift
//  TechTeam
//
//  Created by Ivica Petrsoric on 08/02/2021.
//

import UIKit

class PrgoressIndicator: BaseView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor.primaryColor
        return indicator
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .activeColor
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(white: 0.7, alpha: 0.7).cgColor
        view.layer.borderWidth = 4
        return view
    }()
    
    override func setupViews() {
        alpha = 0
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        addSubview(containerView)
        containerView.addSubview(activityIndicator)

        containerView.anchorCenterSuperview(size: .init(width: 64, height: 64))
        activityIndicator.anchorFillSuperview()
    }
    
    func animate(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = show ? 1 : 0
        }) { (_) in
            if !show {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
}
