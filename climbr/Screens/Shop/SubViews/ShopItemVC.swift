//
//  ItemsGridView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class ShopItemVC: NSViewController {
    
    let pointsLabel = NSTextField(labelWithString: "100")
    let collectionViewContainer = CollectionContainerView()
    let sidebar = NSStackView()
    let contentStack = NSStackView()
    let pointsView = NSStackView()
    let points  = CLLabel(fontSize: 18, fontWeight: .bold)
    
    let sidebarItems: [(imageName: String, text: String)] = [
        ("person.fill", "Headgear"),
        ("bag.fill", "Backpack"),
        ("figure.walk", "Hiking stick"),
        ("map.fill", "Location")
    ]
    
    let headItems1: [EquipmentModel] = EquipmentModel.headGears
    let handItems1: [EquipmentModel] = EquipmentModel.hikingSticks
    let backItems1: [EquipmentModel] = EquipmentModel.backPacks
    let locationItems1: [EquipmentModel] = EquipmentModel.locations
    
    var itemType : EquipmentType = .head
    
    var currentHead : EquipmentItem = .climberCrownHG
    var currentBack : EquipmentItem = .climbingBP
    var currentHand : EquipmentItem = .highWizardS
    var currentLocation : EquipmentItem = .jungleJumble
    
    private var selectedButton: TypeButton?
    var selectedGridItem: GridItem?
    var selectedItem: EquipmentItem?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        
        
        collectionViewContainer.updateItems(items: headItems1)
        collectionViewContainer.collectionDelegate = self
        setupSidebar()
        setupPointsLabel()
        setupCollectionViewContainer()
        horizontalStack()
        
        if let firstButton = sidebar.arrangedSubviews.first as? TypeButton {
            highlightButton(firstButton)
        }
    }
    
    func setupSidebar() {
        sidebar.orientation = .vertical
        sidebar.alignment = .leading
        sidebar.spacing = 10
        var items : [TypeButton] = []
        
        for (index, item) in sidebarItems.enumerated() {
            let button = TypeButton(imageName: item.imageName, text: item.text)
            button.tag = index
            button.target = self
            button.action = #selector(sidebarButtonClicked(_:))
            sidebar.addArrangedSubview(button)
            items.append(button)
        }
        
        sidebar.setViews(items, in: .top)
        sidebar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func horizontalStack(){
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.orientation = .horizontal
        contentStack.alignment = .top
        contentStack.spacing = 10
        
        contentStack.setViews([sidebar, collectionViewContainer], in: .top)
        self.view.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            contentStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
    }
        
    func createSidebarButton(title: String) -> NSButton {
        let button = NSButton(title: title, target: nil, action: nil)
        button.isBordered = false
        button.font = NSFont.systemFont(ofSize: 16)
        button.alignment = .left
        return button
    }
        
    func setupCollectionViewContainer() {
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionViewContainer.widthAnchor.constraint(equalToConstant: 350),
            collectionViewContainer.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
    
    func setupPointsLabel() {
        
        let icon = CLSFSymbol(symbolName: "c.circle", description: "coins")
        icon.setConfiguration(size: 24, weight: .bold)
        icon.contentTintColor = .black
        
        points.setText("100")
        points.backgroundColor = .clear
        points.setTextColor(.black)
        
        pointsView.wantsLayer = true
        
        pointsView.setViews([icon, points], in: .center)
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.orientation = .horizontal
        pointsView.alignment = .centerY
        pointsView.distribution = .equalSpacing
        pointsView.layer?.backgroundColor = .white
        pointsView.layer?.cornerRadius = 10
        pointsView.edgeInsets = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        view.addSubview(pointsView)
        
        NSLayoutConstraint.activate([
            pointsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            pointsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            pointsView.widthAnchor.constraint(equalToConstant: 200),
            pointsView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func highlightButton(_ button: TypeButton) {
        // Unhighlight the previously selected button
        selectedButton?.isSelected = false
        selectedButton?.layer?.backgroundColor = NSColor.lightGray.cgColor // Default color
            
        // Highlight the newly selected button
        selectedButton = button
        selectedButton?.isSelected = true
        selectedButton?.layer?.backgroundColor = NSColor.gray.cgColor // Highlight color
    }
    
    @objc func sidebarButtonClicked(_ sender: TypeButton) {
        highlightButton(sender)
        
        switch sender.tag {
        case 0:
            itemType = .head
            collectionViewContainer.updateItems(items: headItems1)
        case 1:
            itemType = .back
            collectionViewContainer.updateItems(items: backItems1)
        case 2:
            itemType = .hand
            collectionViewContainer.updateItems(items: handItems1)
        case 3:
            itemType = .location
            collectionViewContainer.updateItems(items: locationItems1)
        default:
            break
        }
    }
}

extension ShopItemVC : collectionContainerProtocol {
    func itemSelectedChanged(to newSelected: EquipmentItem) {
        self.selectedItem = newSelected
        
        switch newSelected {
        case .climberCrownHG:
            currentHead = .climberCrownHG
        case .cozyCragglerHG:
            currentHead = .cozyCragglerHG
        case .festiveFollyHG:
            currentHead = .festiveFollyHG
        case .trailbazerTamHG:
            currentHead = .trailbazerTamHG
        case .climbingBP:
            currentBack = .climbingBP
        case .cuddlyBP:
            currentBack = .cuddlyBP
        case .duffelBP:
            currentBack = .duffelBP
        case .hikingBP:
            currentBack = .hikingBP
        case .highWizardS:
            currentHand = .highWizardS
        case .iceGripS:
            currentHand = .iceGripS
        case .natureGuideS:
            currentHand = .natureGuideS
        case .trekTrooperS:
            currentHand = .trekTrooperS
        case .jungleJumble:
            currentLocation = .jungleJumble
        case .snowySummit:
            currentLocation = .snowySummit
        }
        
        print("head: \(currentHead.rawValue), back: \(currentBack.rawValue), hand:\(currentHand.rawValue), location: \(currentLocation.rawValue)")
    }
}
