//
//  ItemsGridView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

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
    
    init(character: CharacterService?, equipment : EquipmentService?){
        super.init(nibName: nil, bundle: nil)
        self.character = character
        self.equipment = equipment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        
        //di sini ngefetch coredata buat currentHeadModel, hand, back, sama location
        if let heads = equipment?.getEquipments(equipmentType: .head) {
            print("berhasil fetch head")
            headItems = heads
        }
        if let backs = equipment?.getEquipments(equipmentType: .back) {
            print("berhasil fetch back")
            backItems = backs
        }
        if let hands = equipment?.getEquipments(equipmentType: .hand) {
            print("berhasil fetch hand")
            handItems = hands
        }
        if let locations = equipment?.getEquipments(equipmentType: .location) {
            print("berhasil fetch locs")
            locationItems = locations
        }
        
        
        collectionViewContainer.collectionDelegate = self
        collectionViewContainer.updateItems(items: headItems)
        collectionViewContainer.updateCurrentItem(head: currentHead, hand: currentHand, back: currentBack, location: currentLocation)
        
        buyButton.updateItemButtonPreview(name: currentHead.name, price: currentHead.price)
        buyButton.isHidden = currentHeadModel.isUnlocked
        
        setupSidebar()
        setupPointsLabel()
        setupCollectionViewContainer()
        horizontalStack()
        setupBuyButton()
        
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
//            points.setText("\(self.currentHead.price)")
            buyButton.updateItemButtonPreview(name: currentHead.name, price: currentHead.price)
            buyButton.isHidden = currentHeadModel.isUnlocked
        case 1:
            itemType = .back
            collectionViewContainer.updateItems(items: backItems)
//            points.setText("\(self.currentBack.price)")
            buyButton.updateItemButtonPreview(name: currentBack.name, price: currentBack.price)
            buyButton.isHidden = currentBackModel.isUnlocked
        case 2:
            itemType = .hand
            collectionViewContainer.updateItems(items: handItems)
//            points.setText("\(self.currentHand.price)")
            buyButton.updateItemButtonPreview(name: currentHand.name, price: currentHand.price)
            buyButton.isHidden = currentHandModel.isUnlocked
        case 3:
            itemType = .location
            collectionViewContainer.updateItems(items: locationItems)
//            points.setText("\(self.currentLocation.price)")
            buyButton.updateItemButtonPreview(name: currentLocation.name, price: currentLocation.price)
            buyButton.isHidden = currentLocationModel.isUnlocked
        default:
            break
        }
    }
}

extension ShopItemVC : collectionContainerProtocol {
    func gridItemSelectedChange(to newSelected: GridItem) {
        self.selectedGridItem = newSelected
        collectionViewContainer.updateCurrentGridItem(gridItem: newSelected)
        points.setText("\(String(describing: newSelected.item?.price))")
        buyButton.updateItemButtonPreview(name: newSelected.item!.name, price: newSelected.item!.price)
        buyButton.isHidden = newSelected.isUnlocked
    }
    
    func itemSelectedChangedWithType(to item: EquipmentItem, type: EquipmentType) {
        self.selectedItem = item
        
        switch type {
        case .head:
            currentHead = item
            currentHeadModel.item = item
            currentHeadModel.isUnlocked = collectionViewContainer.currentGridItem!.isUnlocked
        case .hand:
            currentHand = item
            currentHandModel.item = item
            currentHandModel.isUnlocked = collectionViewContainer.currentGridItem!.isUnlocked
        case .back:
            currentBack = item
            currentBackModel.item = item
            currentBackModel.isUnlocked = collectionViewContainer.currentGridItem!.isUnlocked
        case .location:
            currentLocation = item
            currentLocationModel.item = item
            currentLocationModel.isUnlocked = collectionViewContainer.currentGridItem!.isUnlocked
        }
        
        collectionViewContainer.updateCurrentItem(head: currentHead, hand: currentHand, back: currentBack, location: currentLocation)
        points.setText("\(item.price)")
        buyButton.updateItemButtonPreview(name: item.name, price: item.price)
        buyButton.isHidden = collectionViewContainer.currentGridItem!.isUnlocked
//        print(selectedGridItem?.item?.name)
        collectionViewContainer.collectionView.reloadData()
    }
}
