//
//  BuyButtonView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 17/08/24.
//

import Cocoa
import SnapKit

class BuyButtonView: NSView {
    let itemLabel = CLLabel()
    var itemButton : CLTextButtonV2 = CLTextButtonV2(title: "", backgroundColor: .cButton, foregroundColorText: .black, fontText: .systemFont(ofSize: 24, weight: .medium))
    
    var itemName : String?
    var itemPrice : Int?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
        
    func updateItemButtonPreview(name: String, price: Int){
        self.itemName = name
        self.itemPrice = price
        
        itemLabel.setText(name)
        itemButton.title = "Get for 🪙 \(price)"
    }
    
    func setupUI(){
        wantsLayer = true
        layer?.backgroundColor = .white.copy(alpha: 0.7)
        layer?.cornerRadius = 10
        layer?.shadowRadius = 5
        layer?.shadowOpacity = 0.3
        
//        addSubview(itemButton)
//        addSubview(itemLabel)
        
        setupItemButton()
        setupItemLabel()
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 300),
            self.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupItemLabel(){
        addSubview(itemLabel)
        itemLabel.backgroundColor = .clear
        itemLabel.setFont(ofSize: 26, weight: .bold)
        
        itemLabel.setText("Nama item")
        
        itemLabel.snp.makeConstraints { label in
            label.top.equalToSuperview().inset(30)
            label.centerX.equalToSuperview()
        }
    }
    
    func setupItemButton(){
        itemButton.contentTintColor = .white
        
        addSubview(itemButton)
        
        itemButton.title = "harga item"
        
        itemButton.snp.makeConstraints { button in
            button.leading.trailing.bottom.equalToSuperview().inset(20)
            button.height.equalTo(50)
        }
    }
}
