//
//  GridItemView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class GridItem1: NSCollectionViewItem {
    let textLabel = NSTextField(labelWithString: "")
    
    let lockIcon = CLSFSymbol(symbolName: "lock.fill", description: "lock")
    let itemImage = NSImageView()
    var isUnlocked : Bool?
    
    override func loadView() {
        self.view = NSView()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.view.layer?.cornerRadius = 10
        
        textLabel.font = NSFont.systemFont(ofSize: 20)
        textLabel.alignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        self.view.addSubview(textLabel)
        self.view.addSubview(itemImage)
        self.view.addSubview(lockIcon)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    func configure(isUnlocked : Bool, itemImage : NSImage){
        self.isUnlocked = isUnlocked
        self.itemImage.image = itemImage
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        print("GridItem tapped: \(textLabel.stringValue)")
    }
}

class GridItem: NSCollectionViewItem {
    
    let lockIcon = CLSFSymbol(symbolName: "lock.fill", description: "lock")
    
    let backgroundImageView: NSImageView = {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let overlayView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.5).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.view.layer?.cornerRadius = 10
        
        lockIcon.setConfiguration(size: 24, weight: .bold)
        lockIcon.contentTintColor = .black
        
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)
        view.addSubview(lockIcon)

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
            lockIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configure(text: String, backgroundImage: NSImage?) {
        backgroundImageView.image = backgroundImage
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        print("GridItem tapped")
    }
}
