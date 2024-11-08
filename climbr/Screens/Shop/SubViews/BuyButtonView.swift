//
//  BuyButtonView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 17/08/24.
//

import Cocoa
import SnapKit

protocol BuyButtonDelegate: AnyObject {
    func didPurchased()
}

class BuyButtonView: NSView {
    let itemLabel = CLLabel()
    var itemButton : CLTextButtonV2 = CLTextButtonV2(title: "Purchase", backgroundColor: .cButton, foregroundColorText: .black, fontText: .systemFont(ofSize: 17, weight: .medium))
    
    var item : EquipmentItem?
    
    weak var delegate: BuyButtonDelegate?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        itemButton.action = #selector(buyButtonClicked)
        itemButton.target = self
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        itemButton.action = #selector(buyButtonClicked)
        itemButton.target = self
        setupUI()
    }
    
    func updateItemButtonPreview(item: EquipmentItem, price: Int, point: Int){
        self.item = item
        itemLabel.setText(item.name)
    }
    
    func setupUI(){
        wantsLayer = true
        layer?.backgroundColor = .white.copy(alpha: 0.7)
        layer?.cornerRadius = 10
        layer?.shadowRadius = 5
        layer?.shadowOpacity = 0.3
        setupItemButton()
//        setupItemLabel()
        
        let blur = CLBlurEffectView(frame: bounds)
        addSubview(blur, positioned: .below, relativeTo: nil)
        
//        NSLayoutConstraint.activate([
//            self.widthAnchor.constraint(equalToConstant: 300),
//            self.heightAnchor.constraint(equalToConstant: 150)
//        ])
    }
    
    func setupItemLabel(){
        addSubview(itemLabel)
        itemLabel.backgroundColor = .clear
        itemLabel.setFont(ofSize: 22, weight: .bold)
        
        itemLabel.setText("Nama item")
        
        itemLabel.snp.makeConstraints { label in
            label.top.equalToSuperview().inset(30)
            label.centerX.equalToSuperview()
        }
    }
    
    func setupItemButton(){
        itemButton.contentTintColor = .white
        
        addSubview(itemButton)
        
//        itemButton.title = "harga item"
        
        itemButton.snp.makeConstraints { button in
            button.leading.trailing.bottom.equalToSuperview()
            button.height.equalTo(38)
        }
    }
    
    @objc func buyButtonClicked(){
        delegate?.didPurchased()
    }
}
