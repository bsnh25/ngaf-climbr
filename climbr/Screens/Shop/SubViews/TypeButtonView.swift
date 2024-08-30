//
//  TypeButtonView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class TypeButton: NSButton {
    var isSelected: Bool = false
    
    let stack = NSStackView()
    let icon = CLSFSymbol()
    
    init(imageName: String, text: String){
        super.init(frame: .zero)
        self.wantsLayer = true
        configure(imageName: imageName, text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String, text: String){
        icon.image = NSImage(systemSymbolName: imageName, accessibilityDescription: imageName)
        icon.contentTintColor = .darkGray

        let label = CLLabel(text: text, foregroundColor: .blue)
        label.backgroundColor = .clear
        label.setTextColor(.darkGray)
        label.setFont(ofSize: 17, weight: .bold)
        
        icon.setConfiguration(size: 24, weight: .bold)
        
        stack.setViews([icon, label], in: .center)
        stack.orientation = .vertical
        stack.spacing = 10
        
        title = ""
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor.copy(alpha: 0.6)
        layer?.cornerRadius = 10
        bezelStyle = .flexiblePush
        isBordered = false

        addSubview(icon)
        
        let blur = CLBlurEffectView(frame: bounds)
        addSubview(blur, positioned: .below, relativeTo: nil)
        
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            widthAnchor.constraint(equalToConstant: 50),
            heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func updateItemIcon(_ isActive: Bool){
        if isActive{
            icon.contentTintColor = .cButton
        }else{
            icon.contentTintColor = .darkGray
        }
    }
}
