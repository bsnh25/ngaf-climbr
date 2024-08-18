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
    
    var currentHead : EquipmentItem?
    var currentBack : EquipmentItem?
    var currentHand : EquipmentItem?
    var currentLocation : EquipmentItem?
    
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
        layer?.backgroundColor = NSColor.white.cgColor.copy(alpha: 0.7)
        layer?.cornerRadius = 10
        bezelStyle = .flexiblePush
        isBordered = false
//        
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(stack)
        addSubview(icon)
        
        NSLayoutConstraint.activate([
//            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
//            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
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

//    override func updateLayer() {
//       super.updateLayer()
//        if isHighlighted {
//            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 0.7)
//        } else {
//            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 1.0)
//        }
//        if !isEnabled {
//            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 0.2)
//        }
//    }
}
