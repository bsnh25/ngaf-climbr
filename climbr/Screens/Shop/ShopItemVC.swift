//
//  ItemsGridView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa
import AppKit
import SnapKit
import RiveRuntime

class ShopItemVC: NSViewController {
    var characterService : CharacterService?
    var equipmentService : EquipmentService?
    
    let pointsLabel = NSTextField(labelWithString: "100")
    let collectionViewContainer = CollectionContainerView()
    let sidebar = NSStackView()
    let contentStack = NSStackView()
    let pointsView = NSStackView()
    let points  = CLLabel(fontSize: 18, fontWeight: .bold)
    let buyButton = BuyButtonView()
    weak var delegate: ChooseCaraterDelegate?
    
    
    let sidebarItems: [(imageName: String, text: String)] = [
        ("hat.cap", "Headgear"),
        ("backpack", "Backpack"),
        ("figure.hiking", "Hiking stick"),
        ("map", "Location")
    ]
    
//    var headItems: [EquipmentModel] = EquipmentModel.headGears
//    var handItems: [EquipmentModel] = EquipmentModel.hikingSticks
//    var backItems: [EquipmentModel] = EquipmentModel.backPacks
//    var locationItems: [EquipmentModel] = EquipmentModel.locations
    
    var itemType : EquipmentType = .head
    
    var character: CharacterModel?
    
//    var currentHead : EquipmentItem = .emptyHG
//    var currentBack : EquipmentItem = .emptyBP
//    var currentHand : EquipmentItem = .emptyS
//    var currentLocation : EquipmentItem = .jungleJumble
//    
//    var currentHeadModel : EquipmentModel = EquipmentModel(item: .emptyHG, type: .head, isUnlocked: true)
//    var currentHandModel : EquipmentModel = EquipmentModel(item: .emptyS, type: .hand, isUnlocked: true)
//    var currentBackModel : EquipmentModel = EquipmentModel(item: .emptyBP, type: .back, isUnlocked: true)
//    var currentLocationModel : EquipmentModel = EquipmentModel(item: .jungleJumble, type: .location, isUnlocked: true)
    
    private var selectedButton: TypeButton?
//    var selectedGridItem: GridItem?
    var selectedItem : EquipmentModel?
    
//    var simpleVM = RiveViewModel(fileName: "climbr")
    var animationShop : RiveViewModel? = {
        var anima: RiveViewModel = RiveViewModel(fileName: "climbr")
        anima.fit = .fill
        let riveView = anima.createRiveView()
        return anima
    }()
    
    let backButton = CLImageButton(
        imageName: "arrowshape.backward",
        accesibilityName: "back home",
        imgColor: .black.withAlphaComponent(0.5),
        bgColor: NSColor.cContainerHome.cgColor.copy(alpha: 0.84)!
    )
    
    init(character: CharacterService?, equipment : EquipmentService?){
        super.init(nibName: nil, bundle: nil)
        self.characterService = character
        self.equipmentService = equipment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        
        collectionViewContainer.collectionDelegate = self
        buyButton.delegate = self
        setupAnimationView()
        
        setupSidebar()
        setupPointsLabel()
        setupCollectionViewContainer()
        horizontalStack()
        setupBuyButton()
        setupBackButton()
        
        if let firstButton = sidebar.arrangedSubviews.first as? TypeButton {
            highlightButton(firstButton)
        }
    }
    
    override func viewDidAppear() {
        self.updateData(with: itemType)
        getCharacterData()
    }
    
    func getCharacterData() {
        self.character = characterService?.getCharacterData()
        
        if let character = self.character {
            /// Set current character's point
            points.setText("\(character.point)")
            /// Select first init to current head equipment
            collectionViewContainer.selectCurrentItem(with: selectedItem?.item ?? character.headEquipment)
            
            /// Configure rive artboard
            do {
                try animationShop?.configureModel(artboardName: character.gender == .male ? "ShopscreenMale" : "ShopscreenFemale")
            } catch {
                print(error.localizedDescription)
            }
            
            /// Update character equipment
            updateCharacterEquipment()
        }
    }
    
    func setupAnimationView(){
        if let riveView = animationShop?.createRiveView() {
            view.addSubview(riveView)
            
            riveView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                riveView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                riveView.topAnchor.constraint(equalTo: view.topAnchor),
                riveView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                riveView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    }
    
    func setupBuyButton(){
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buyButton)
        
        /// Hide the buy button for the first time
        buyButton.isHidden = true
        
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: collectionViewContainer.bottomAnchor, constant: 16),
            buyButton.leadingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor),
            buyButton.trailingAnchor.constraint(equalTo: collectionViewContainer.trailingAnchor),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
//            buyButton.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor)
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
        collectionViewContainer.layer?.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            collectionViewContainer.widthAnchor.constraint(equalToConstant: 400),
            collectionViewContainer.heightAnchor.constraint(equalToConstant: 400)
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
        
        let blur = CLBlurEffectView(frame: pointsView.bounds)
        
        pointsView.addSubview(blur, positioned: .below, relativeTo: nil)
        
        pointsView.setViews([icon, points], in: .center)
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.orientation = .horizontal
        pointsView.alignment = .centerY
        pointsView.distribution = .equalSpacing
        pointsView.layer?.backgroundColor = .white.copy(alpha: 0.72)
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
        selectedButton?.layer?.backgroundColor = .white.copy(alpha: 0.84) // Highlight color
        selectedButton?.updateItemIcon(true)
    }
    
//    func updateGridItemsWithSelectedItem() {
//        for index in 0..<collectionViewContainer.collectionView.numberOfItems(inSection: 0) {
//            if let gridItem = collectionViewContainer.collectionView.item(at: index) as? GridItem {
////                gridItem.updateItemSelected(head: currentHead, hand: currentHand, back: currentBack, location: currentLocation)
//            }
//        }
//    }
    
    @objc func sidebarButtonClicked(_ sender: TypeButton) {
        guard let character else { return }
        
        highlightButton(sender)

        switch sender.tag {
        case 0:
            itemType = .head
            updateData(with: .head)
            collectionViewContainer.selectCurrentItem(with: character.headEquipment)
//            collectionViewContainer.updateItems(items: headItems)
//            buyButton.updateItemButtonPreview(item: currentHead, price: currentHead.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = currentHeadModel.isUnlocked
        case 1:
            itemType = .back
            updateData(with: .back)
            collectionViewContainer.selectCurrentItem(with: character.backEquipment)
//            collectionViewContainer.updateItems(items: backItems)
//            buyButton.updateItemButtonPreview(item: currentBack, price: currentBack.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = currentBackModel.isUnlocked
        case 2:
            itemType = .hand
            updateData(with: .hand)
            collectionViewContainer.selectCurrentItem(with: character.handEquipment)
//            collectionViewContainer.updateItems(items: handItems)
//            buyButton.updateItemButtonPreview(item: currentHand, price: currentHand.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = currentHandModel.isUnlocked
        case 3:
            itemType = .location
            updateData(with: .location)
            collectionViewContainer.selectCurrentItem(with: character.locationEquipment)
//            collectionViewContainer.selectCurrentItem(with: character.location)
//            collectionViewContainer.updateItems(items: locationItems)
//            buyButton.updateItemButtonPreview(item: currentLocation, price: currentLocation.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = currentLocationModel.isUnlocked
        default:
            break
        }
        animationShop!.setInput("Headgear", value: Double(character.headEquipment.itemID))
        animationShop!.setInput("Stick", value: Double(character.handEquipment.itemID))
        animationShop!.setInput("Jacket", value: Double(character.handEquipment.itemID))
        animationShop!.setInput("RightThigh", value: Double(character.handEquipment.itemID))
        animationShop!.setInput("LeftThigh", value: Double(character.handEquipment.itemID))
        animationShop!.setInput("RightShin", value: Double(character.handEquipment.itemID))
        animationShop!.setInput("LeftShin", value: Double(character.handEquipment.itemID))
        animationShop!.setInput("Backpack", value: Double(character.backEquipment.itemID))
        animationShop!.setInput("Tent", value: Double(character.backEquipment.itemID))
        animationShop!.setInput("Background", value: Double(character.locationEquipment.itemID))
        
        buyButton.isHidden = true
    }
   
    func updateData(with type: EquipmentType = .head) {
        if let items = equipmentService?.getEquipments(equipmentType: type) {
            collectionViewContainer.updateItems(items: items)
        }
    }
    
    @objc func backToMenu(){
        pop()
    }
}
