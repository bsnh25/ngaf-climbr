//
//  LrContainerView.swift
//  limbr
//
//  Created by I Gusti Ngurah Surya Ardika Dinataputra on 05/08/24.
//

import UIKit

class LrContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(frame: .zero)
        configure()
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints   = false
        layer.backgroundColor                       = UIColor(resource: .containerBackground).cgColor
        layer.cornerRadius                          = 20
        layer.borderColor                           = UIColor(resource: .containerBackground).cgColor
    }
    
}
