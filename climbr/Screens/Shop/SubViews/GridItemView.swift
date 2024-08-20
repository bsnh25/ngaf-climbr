//
//  GridItemView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

protocol gridItemSelectionProtocol {
//    func gridItemSelectionDidChange(to newSelected: GridItem)
    func gridItemSelectionDidChange(to newSelected: EquipmentItem, type: EquipmentType, isUnlocked: Bool)
}

class GridItem: NSCollectionViewItem {
    
    let lockIcon = CLSFSymbol(symbolName: "lock.fill", description: "lock")
    var gridDelegate : gridItemSelectionProtocol?
    
//    override var isSelected: Bool
    
    let backgroundImageView: NSImageView = {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let overlayView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.black.withAlphaComponent(0.2).cgColor
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
    
    var type : EquipmentType?
    var itemId: Int?
    var item: EquipmentItem?
    var isUnlocked = true
    
    var currentHead : EquipmentItem?
    var currentBack : EquipmentItem?
    var currentHand : EquipmentItem?
    var currentLocation : EquipmentItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.lightGray.cgColor.copy(alpha: 0.5)
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
        item = equipmentModel.item
        itemId = Int(equipmentModel.item.itemID)
        type = equipmentModel.type
        isUnlocked = equipmentModel.isUnlocked
        overlayView.isHidden = equipmentModel.isUnlocked
        lockIcon.isHidden = equipmentModel.isUnlocked
//        print(item?.rawValue ?? "lol")
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        gridDelegate?.gridItemSelectionDidChange(to: item!, type: type!, isUnlocked: isUnlocked)
        setSelected(self.currentHead == item || self.currentHand == item || self.currentBack == item || self.currentLocation == item)
    }
    
    func setSelected(_ selected: Bool) {
        borderView.layer?.borderWidth = selected ? 4 : 0
        print("\(item?.name) is currently selected with \(selected)")
    }
    
//    func updateSelectedGridItem(gridItemSelected: GridItem){
//        if gridItemSelected == self {
//            setSelected(true)
//        }else{
//            setSelected(false)
//        }
//    }
    
    func updateItemSelected(head: EquipmentItem, hand: EquipmentItem, back: EquipmentItem, location: EquipmentItem) {
        self.currentHead = head
        self.currentHand = hand
        self.currentBack = back
        self.currentLocation = location
        setSelected(head == item || hand == item || back == item || location == item)
    }
    
    func updateCurrentItem(head: EquipmentItem, hand: EquipmentItem, back: EquipmentItem, location: EquipmentItem){
        self.currentHead = head
        self.currentHand = hand
        self.currentBack = back
        self.currentLocation = location
    }
    
    func updateSelectedItem(head: EquipmentItem, hand: EquipmentItem, back: EquipmentItem, location: EquipmentItem){
        print("head: \(head.rawValue), back: \(back.rawValue), hand:\(hand.rawValue), location: \(location.rawValue)")
    }
}
