//
//  ItemsGridView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa
import AppKit
import SnapKit

class ShopItemVC: NSViewController {
    var character : CharacterService?
    var equipment : EquipmentService?
    
    let pointsLabel = NSTextField(labelWithString: "100")
    let collectionViewContainer = CollectionContainerView()
    let sidebar = NSStackView()
    let contentStack = NSStackView()
    let pointsView = NSStackView()
    let points  = CLLabel(fontSize: 18, fontWeight: .bold)
    let buyButton = BuyButtonView()
    
    
    let sidebarItems: [(imageName: String, text: String)] = [
        ("person.fill", "Headgear"),
        ("bag.fill", "Backpack"),
        ("figure.walk", "Hiking stick"),
        ("map.fill", "Location")
    ]
    
    var headItems: [EquipmentModel] = EquipmentModel.headGears
    var handItems: [EquipmentModel] = EquipmentModel.hikingSticks
    var backItems: [EquipmentModel] = EquipmentModel.backPacks
    var locationItems: [EquipmentModel] = EquipmentModel.locations
    
    var itemType : EquipmentType = .head
    
    var currentHead : EquipmentItem = .emptyHG
    var currentBack : EquipmentItem = .emptyBP
    var currentHand : EquipmentItem = .emptyS
    var currentLocation : EquipmentItem = .jungleJumble
    
    var currentHeadModel : EquipmentModel = EquipmentModel(item: .emptyHG, type: .head, isUnlocked: true)
    var currentHandModel : EquipmentModel = EquipmentModel(item: .emptyS, type: .hand, isUnlocked: true)
    var currentBackModel : EquipmentModel = EquipmentModel(item: .emptyBP, type: .back, isUnlocked: true)
    var currentLocationModel : EquipmentModel = EquipmentModel(item: .jungleJumble, type: .location, isUnlocked: true)
    
    private var selectedButton: TypeButton?
    var selectedGridItem: GridItem?
    var selectedItem : EquipmentItem?
    
    let backButton = CLImageButton(
        imageName: "arrowshape.backward",
        accesibilityName: "back home",
        imgColor: .black.withAlphaComponent(0.5),
        bgColor: NSColor.cContainerHome.cgColor.copy(alpha: 0.84)!
    )
    
    init(character: CharacterService?, equipment : EquipmentService?){
        super.init(nibName: nil, bundle: nil)
        self.character = character
        self.equipment = equipment
        buyButton.setupService(equipment: equipment!, character: character!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        
        if let heads = equipment?.getEquipments(equipmentType: .head) {
            headItems = heads
            if let char = character?.getCharacterData()?.headEquipment{
                currentHead = char
                print("head di sini \(char.name)")
            }
        }
        if let backs = equipment?.getEquipments(equipmentType: .back) {
            backItems = backs
            if let char = character?.getCharacterData()?.backEquipment{
                currentBack = char
                print("back di sini \(char.name)")
            }
        }
        if let hands = equipment?.getEquipments(equipmentType: .hand) {
            handItems = hands
            if let char = character?.getCharacterData()?.handEquipment{
                currentHand = char
                print("hand di sini \(char.name)")
            }
        }
        if let locations = equipment?.getEquipments(equipmentType: .location) {
            locationItems = locations
        }
        
        selectedItem = .emptyHG
        
        collectionViewContainer.collectionDelegate = self
        collectionViewContainer.updateItems(items: headItems)
        collectionViewContainer.updateCurrentItem(head: currentHead, hand: currentHand, back: currentBack, location: currentLocation)
        
        buyButton.updateItemButtonPreview(item: currentHead, price: currentHead.price, point: Int((character?.getCharacterData()!.point)!))
        buyButton.isHidden = currentHeadModel.isUnlocked
        buyButton.delegate = self
        
        view.layer?.backgroundColor = NSColor.blue.cgColor
        
        setupSidebar()
        setupPointsLabel()
        setupCollectionViewContainer()
        horizontalStack()
        setupBuyButton()
        setupBackButton()
        
        if let firstButton = sidebar.arrangedSubviews.first as? TypeButton {
            updateGridItemsWithSelectedItem()
            highlightButton(firstButton)
        }
        
        points.setText(String((character?.getCharacterData()!.point)!))
    }
    
    override func viewDidAppear() {
        collectionViewContainer.updateItems(items: headItems)
    }
    
    func setupBuyButton(){
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buyButton)
        
        NSLayoutConstraint.activate([
            buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 225),
            buyButton.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor)
        ])
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
    
    func setupBackButton(){
        view.addSubview(backButton)

        backButton.action = #selector(backToMenu)
        backButton.target = self
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 45),
            backButton.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func setupPointsLabel() {
        
        let icon = CLSFSymbol(symbolName: "c.circle", description: "coins")
        icon.setConfiguration(size: 24, weight: .bold)
        icon.contentTintColor = .black
        
        points.backgroundColor = .clear
        points.setTextColor(.black)
        
        pointsView.wantsLayer = true
        
        pointsView.setViews([icon, points], in: .center)
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.orientation = .horizontal
        pointsView.alignment = .centerY
        pointsView.distribution = .equalSpacing
        pointsView.layer?.backgroundColor = .white.copy(alpha: 0.7)
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
        selectedButton?.isSelected = false
        selectedButton?.layer?.backgroundColor = NSColor.white.cgColor.copy(alpha: 0.7)
        selectedButton?.updateItemIcon(false)
        

        selectedButton = button
        selectedButton?.isSelected = true
        selectedButton?.layer?.backgroundColor = NSColor.white.cgColor // Highlight color
        selectedButton?.updateItemIcon(true)
    }
    
    func updateGridItemsWithSelectedItem() {
        for index in 0..<collectionViewContainer.collectionView.numberOfItems(inSection: 0) {
            if let gridItem = collectionViewContainer.collectionView.item(at: index) as? GridItem {
                gridItem.updateItemSelected(head: currentHead, hand: currentHand, back: currentBack, location: currentLocation)
            }
        }
    }
    
    @objc func sidebarButtonClicked(_ sender: TypeButton) {
        highlightButton(sender)

        switch sender.tag {
        case 0:
            itemType = .head
            collectionViewContainer.updateItems(items: headItems)
            buyButton.updateItemButtonPreview(item: currentHead, price: currentHead.price, point: Int((character?.getCharacterData()!.point)!))
            buyButton.isHidden = currentHeadModel.isUnlocked
        case 1:
            itemType = .back
            collectionViewContainer.updateItems(items: backItems)
            buyButton.updateItemButtonPreview(item: currentBack, price: currentBack.price, point: Int((character?.getCharacterData()!.point)!))
            buyButton.isHidden = currentBackModel.isUnlocked
        case 2:
            itemType = .hand
            collectionViewContainer.updateItems(items: handItems)
            buyButton.updateItemButtonPreview(item: currentHand, price: currentHand.price, point: Int((character?.getCharacterData()!.point)!))
            buyButton.isHidden = currentHandModel.isUnlocked
        case 3:
            itemType = .location
            collectionViewContainer.updateItems(items: locationItems)
            buyButton.updateItemButtonPreview(item: currentLocation, price: currentLocation.price, point: Int((character?.getCharacterData()!.point)!))
            buyButton.isHidden = currentLocationModel.isUnlocked
        default:
            break
        }
    }
    
    @objc func backToMenu(){
        pop()
    }
}

extension ShopItemVC : collectionContainerProtocol {
    func updateCurrentItem(head: EquipmentItem, hand: EquipmentItem, back: EquipmentItem, location: EquipmentItem, isUnlocked: Bool, type: EquipmentType) {
//        self.collectionViewContainer.collectionView.reloadData()
        
        currentHead = head
        currentHeadModel.item = head
        currentHand = hand
        currentHandModel.item = hand
        currentBack = back
        currentBackModel.item = back
        currentLocation = location
        currentLocationModel.item = location
        
        switch type {
        case .head:
            currentHeadModel.isUnlocked = isUnlocked
            buyButton.updateItemButtonPreview(item: head, price: head.price, point: Int((character?.getCharacterData()!.point)!))
            
            print("di dalem head \(head.name)")
            if selectedItem != head {
                let temporaryItem = selectedItem
                selectedItem = head
                buyButton.isHidden = isUnlocked
                if temporaryItem != selectedItem{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.collectionViewContainer.collectionView.reloadData()
                    }
                }
            }
        case .hand:
            currentHandModel.isUnlocked = isUnlocked
            buyButton.updateItemButtonPreview(item: hand, price: hand.price, point: Int((character?.getCharacterData()!.point)!))
            
            
            print("di dalem hand \(hand.name)")
            if selectedItem != hand {
                let temporaryItem = selectedItem
                selectedItem = hand
                buyButton.isHidden = isUnlocked
                if temporaryItem != selectedItem{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.collectionViewContainer.collectionView.reloadData()
                    }
                }
            }
        case .back:
            currentBackModel.isUnlocked = isUnlocked
            buyButton.updateItemButtonPreview(item: back, price: back.price, point: Int((character?.getCharacterData()!.point)!))
            print("di dalem back \(back.name)")
            if selectedItem != back {
                let temporaryItem = selectedItem
                selectedItem = back
                buyButton.isHidden = isUnlocked
                if temporaryItem != selectedItem{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.collectionViewContainer.collectionView.reloadData()
                    }
                }
            }
        case .location:
            currentLocationModel.isUnlocked = isUnlocked
            buyButton.updateItemButtonPreview(item: location, price: location.price, point: Int((character?.getCharacterData()!.point)!))
            print("di dalem loc \(location.name)")
            if selectedItem != location {
                let temporaryItem = selectedItem
                selectedItem = location
                buyButton.isHidden = isUnlocked
                if temporaryItem != selectedItem{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.collectionViewContainer.collectionView.reloadData()
                    }
                }
            }
        }
//        self.collectionViewContainer.collectionView.reloadData()
    }
    
    func itemSelectedChangedWithType(to item: EquipmentItem, type: EquipmentType, isUnlocked: Bool) {
        self.selectedItem = item
        
        switch type {
        case .head:
            currentHead = item
            currentHeadModel.item = item
            currentHeadModel.isUnlocked = isUnlocked
        case .hand:
            currentHand = item
            currentHandModel.item = item
            currentHandModel.isUnlocked = isUnlocked
        case .back:
            currentBack = item
            currentBackModel.item = item
            currentBackModel.isUnlocked = isUnlocked
        case .location:
            currentLocation = item
            currentLocationModel.item = item
            currentLocationModel.isUnlocked = isUnlocked
        }
        
        print("head : \(currentHead), hand: \(currentHand), back: \(currentBack), location: \(currentLocation)")
        
        collectionViewContainer.updateCurrentItem(head: currentHead, hand: currentHand, back: currentBack, location: currentLocation)
//        points.setText("\(item.price)")
        buyButton.updateItemButtonPreview(item: item, price: item.price, point: Int((character?.getCharacterData()!.point)!))
        buyButton.isHidden = isUnlocked
//        print(selectedGridItem?.item?.name)
        collectionViewContainer.collectionView.reloadData()
    }
}

extension ShopItemVC: gridItemSelectionProtocol {
    func gridItemSelectionDidChange(to newSelected: EquipmentItem, type: EquipmentType, isUnlocked: Bool) {
        selectedItem = newSelected
        buyButton.updateItemButtonPreview(item: newSelected, price: newSelected.price, point: Int((character?.getCharacterData()!.point)!))
        buyButton.isHidden = isUnlocked
        print("buyButton")
    }
    
    func gridItemSelectionDidChange(to newSelected: GridItem) {
        print("dalam sini")
        self.selectedGridItem = newSelected
        collectionViewContainer.updateCurrentGridItem(gridItem: newSelected)
        points.setText("\(String(describing: newSelected.item?.price))")
        buyButton.updateItemButtonPreview(item: newSelected.item!, price: newSelected.item!.price, point: Int((character?.getCharacterData()!.point)!))
        buyButton.isHidden = newSelected.isUnlocked
    }
}

extension ShopItemVC: collectionItemProtocol{
    func collectionItemDidChange(to newSelected: EquipmentItem, type: EquipmentType, isUnlocked: Bool) {
        selectedItem = newSelected
        
        switch type {
        case .head:
            currentHead = newSelected
            currentHeadModel.item = newSelected
            currentHeadModel.isUnlocked = isUnlocked
        case .hand:
            currentHand = newSelected
            currentHandModel.item = newSelected
            currentHandModel.isUnlocked = isUnlocked
        case .back:
            currentBack = newSelected
            currentBackModel.item = newSelected
            currentBackModel.isUnlocked = isUnlocked
        case .location:
            currentLocation = newSelected
            currentLocationModel.item = newSelected
            currentLocationModel.isUnlocked = isUnlocked
        }
        
        collectionViewContainer.collectionView.reloadData()
        
        print("head : \(currentHead), hand: \(currentHand), back: \(currentBack), location: \(currentLocation)")
        
        print(newSelected.name)
        buyButton.updateItemButtonPreview(item: newSelected, price: newSelected.price, point: Int((character?.getCharacterData()!.point)!))
        buyButton.isHidden = isUnlocked
        print("dalam collectionItemDidChange di VC -> \(newSelected.name)")
    }
}

extension ShopItemVC: BuyButtonDelegate {
    func didPurchaseItem() {
        print("masuk ke didPurchaseItem")
        print(itemType.rawValue)
        if let heads = equipment?.getEquipments(equipmentType: .head) {
            headItems = heads
        }
        if let backs = equipment?.getEquipments(equipmentType: .back) {
            backItems = backs
        }
        if let hands = equipment?.getEquipments(equipmentType: .hand) {
            handItems = hands
        }
        if let locations = equipment?.getEquipments(equipmentType: .location) {
            locationItems = locations
        }
        
//        collectionViewContainer.updateItems
        switch itemType {
        case .head:
            collectionViewContainer.updateItems(items: headItems)
            
            buyButton.updateItemButtonPreview(item: currentHead, price: currentHead.price, point: Int((character?.getCharacterData()!.point)!))
            buyButton.isHidden = true
        case .hand:
            collectionViewContainer.updateItems(items: handItems)
            
            buyButton.updateItemButtonPreview(item: currentHand, price: currentHand.price, point: Int((character?.getCharacterData()!.point)!))
            buyButton.isHidden = true
        case .back:
            collectionViewContainer.updateItems(items: backItems)
            
            buyButton.updateItemButtonPreview(item: currentBack, price: currentBack.price, point: Int((character?.getCharacterData()!.point)!))
            buyButton.isHidden = true
        case .location:
            collectionViewContainer.updateItems(items: locationItems)
            
            buyButton.updateItemButtonPreview(item: currentLocation, price: currentLocation.price, point: Int((character?.getCharacterData()!.point)!))
            buyButton.isHidden = true
        }
        
        collectionViewContainer.updateCurrentItem(head: currentHead, hand: currentHand, back: currentBack, location: currentLocation)
        
        collectionViewContainer.collectionView.reloadData()
        points.setText(String((character?.getCharacterData()!.point)!))
    }
}
