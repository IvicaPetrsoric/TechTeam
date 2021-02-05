//
//  BaseView.swift
//  LikeFlickr
//
//  Created by Ivica Petrsoric on 15/01/2021.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// custom implementation
    func setup() {}
    
    /// custom implementation views
    func setupViews() {}
    
}
