//
//  TypeButtonView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class CustomButton: NSButton {
    var isSelected: Bool = false {
            didSet {
                updateLayer()
            }
        }
    let stack = NSStackView()
    
    init(imageName: String, text: String){
        super.init(frame: .zero)
        self.wantsLayer = true
        configure(imageName: imageName, text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageName: String, text: String){
        let icon = CLSFSymbol(symbolName: imageName, description: imageName)
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
        layer?.backgroundColor = NSColor.gray.cgColor
        layer?.cornerRadius = 10
        bezelStyle = .flexiblePush
        isBordered = false
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            widthAnchor.constraint(equalToConstant: 121),
            heightAnchor.constraint(equalToConstant: 84)
        ])
    }
    
    override func updateLayer() {
       super.updateLayer()
        if isHighlighted {
            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 0.7)
        } else {
            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 1.0)
        }
        
        if !isEnabled {
            layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 0.2)
        }
   }
}
