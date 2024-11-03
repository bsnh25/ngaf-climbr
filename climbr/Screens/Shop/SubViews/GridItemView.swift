//
//  GridItemView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa


class GridItem: NSCollectionViewItem {
    
    let lockIcon = CLSFSymbol(symbolName: "lock.fill", description: "lock")
    
    let backgroundImageView: NSImageView = {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.layer?.backgroundColor = NSColor.lightGray.cgColor.copy(alpha: 0.3)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let overlayView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.darkGray.cgColor.copy(alpha: 0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let borderView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.borderColor = NSColor.cButton.cgColor
        view.layer?.cornerRadius = 10
        view.layer?.borderWidth = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            borderView.layer?.borderWidth = isSelected ? 4 : 0
        }
    }
    
    var data: EquipmentModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.8).cgColor
        self.view.layer?.cornerRadius = 10
        
        lockIcon.setConfiguration(size: 24, weight: .bold)
        lockIcon.contentTintColor = .black
        
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)
        view.addSubview(lockIcon)
        view.addSubview(borderView)

        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            lockIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lockIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            borderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            borderView.topAnchor.constraint(equalTo: view.topAnchor),
            borderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configure(text: String, backgroundImage: NSImage?) {
        backgroundImageView.image = backgroundImage
    }

    func configure(equipmentModel: EquipmentModel) {
        backgroundImageView.image = NSImage(named: equipmentModel.item.image)
        data = equipmentModel
        overlayView.isHidden = equipmentModel.isUnlocked
        lockIcon.isHidden = equipmentModel.isUnlocked
    }
}
