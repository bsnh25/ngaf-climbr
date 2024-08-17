//
//  TutorialVC.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 17/08/24.
//

import Cocoa

class TutorialVC: NSViewController {
    
    let container = NSView()
    let character = NSImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.backgroundColor = .black
        
        configureContainer()
    }
    
    func configureContainer(){
        view.addSubview(container)
        container.wantsLayer = true
        container.layer?.backgroundColor = .white
        
        let padding = view.bounds.width * 0.05
        let height = view.bounds.height * 0.5
        
        container.snp.makeConstraints { container in
            container.bottom.leading.trailing.equalToSuperview().inset(padding)
            container.height.equalTo(height)
        }
    }
    
    func configureChar(){
        view.addSubview(character)
        
    }
    
    func setChar(){
        
    }
    
}

#Preview(traits: .defaultLayout, body: {
    TutorialVC()
})
