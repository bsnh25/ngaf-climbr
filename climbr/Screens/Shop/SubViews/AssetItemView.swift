//
//  AssetItemView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class AssetItemView: NSView {
    
    let imageView = NSImageView()
    let imageLockView = NSImageView(image: NSImage(systemSymbolName: "lock.fill", accessibilityDescription: nil)!)
    var isAvailable: Bool
    var equipment: EquipmentModel

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    init(equipment: EquipmentModel ,isAvailable: Bool) {
        self.isAvailable = isAvailable
        self.equipment = equipment
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        setupImageView(equipment: equipment)
    }
    
    private func setupImageView(equipment: EquipmentModel){
        imageView.image = NSImage(named: equipment.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.wantsLayer = true
        imageView.layer?.cornerRadius = 10
        imageView.layer?.masksToBounds = true
        
        addSubview(imageView)
        
        if !isAvailable {
            imageLockView.translatesAutoresizingMaskIntoConstraints = false
            imageLockView.alphaValue = 0.6
            addSubview(imageLockView)
        }
        
        layer?.backgroundColor = NSColor(red: 192, green: 192, blue: 192, alpha: 1).cgColor
        layer?.cornerRadius = 10
        layer?.shadowOpacity = 0.3
        layer?.shadowOffset = CGSize(width: 0, height: 2)
        layer?.shadowRadius = 5
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        if !isAvailable{
            NSLayoutConstraint.activate([
                imageLockView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageLockView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }

}
