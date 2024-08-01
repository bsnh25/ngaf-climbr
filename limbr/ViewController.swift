//
//  ViewController.swift
//  limbr
//
//  Created by Ivan Nur Ilham Syah on 01/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    let rightView = UIImageView()
    let leftView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        
        button.configuration = .tinted()
        button.configuration?.title = "Test"
        button.configuration?.baseBackgroundColor = .systemRed
        button.configuration?.baseForegroundColor = .systemRed
        
        view.addSubview(button)
        
        configure()
    }
    
    private func configure() {
        view.addSubview(rightView)
        view.addSubview(leftView)
        
        rightView.translatesAutoresizingMaskIntoConstraints = false
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.backgroundColor = .white
        
        //        rightView.largeContentImage = UIImage(resource: .rectangle)
        
        /// Constraint leftview
        NSLayoutConstraint.activate([
            leftView.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            leftView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        /// Constraint rightview
        NSLayoutConstraint.activate([
            rightView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightView.leadingAnchor.constraint(equalTo: leftView.trailingAnchor),
            rightView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rightView.topAnchor.constraint(equalTo: view.topAnchor),
            rightView.widthAnchor.constraint(equalToConstant: leftView.bounds.width)
        ])
    }

}

