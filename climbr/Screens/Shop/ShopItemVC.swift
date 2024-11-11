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
    var characterService : CharacterService = UserManager.shared
    var equipmentService : EquipmentService?
    
    let pointsLabel = NSTextField(labelWithString: "100")
    let collectionViewContainer = CollectionContainerView()
    let sidebar = NSStackView()
    let contentStack = NSStackView()
    let pointsView = NSStackView()
    let points  = CLLabel(fontSize: 18, fontWeight: .bold)
    let buyButton = BuyButtonView()
    let priceLabel = CLLabel(fontSize: 20, fontWeight: .bold)
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
    
//    let backButton = CLImageButton(
//        imageName: "arrowshape.backward",
//        accesibilityName: "back home",
//        imgColor: .black.withAlphaComponent(0.5),
//        bgColor: NSColor.cContainerHome.cgColor.copy(alpha: 0.84)!
//    )
    let backButton = TypeButton(imageName: "arrowshape.backward", text: "Back to Home Page")
    
    init(equipment : EquipmentService?){
        super.init(nibName: nil, bundle: nil)
        self.equipmentService = equipment
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
//        view.layer?.backgroundColor = .clear
//        view.alphaValue = 0
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer?.borderWidth = 10
//        view.layer?.borderColor = NSColor.purple.cgColor
        
        collectionViewContainer.collectionDelegate = self
        buyButton.delegate = self
        setupAnimationView()
        setupBackButton()
        setupSidebar()
        setupCollectionViewContainer()
        horizontalStack()
        setupBuyButton()
        setupPointsLabel()
        
        if let firstButton = sidebar.arrangedSubviews.first as? TypeButton {
            highlightButton(firstButton)
        }
    }
    
    override func viewDidAppear() {
        self.updateData(with: itemType)
        getCharacterData()
    }
    
    func getCharacterData() {
        self.character = characterService.getCharacterData()
        
        if let character = self.character {
            /// Set current character's point
            points.setText("\(character.point)")
            /// Select first init to current head equipment
            collectionViewContainer.selectCurrentItem(with: selectedItem?.item ?? character.headEquipment)
            ///
            priceLabel.setText("􀀈\(character.headEquipment.price)")
            priceLabel.setAccessibilityTitle("Current equipment price is \(character.headEquipment.price)")
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
        
        collectionViewContainer.HInnerStack.addArrangedSubview(priceLabel)
        collectionViewContainer.HInnerStack.addArrangedSubview(buyButton)
//        priceLabel.setText("􀀈 0")
        priceLabel.wantsLayer = true
//        priceLabel.layer?.borderColor = NSColor.purple.cgColor
//        priceLabel.layer?.borderWidth = 2
        
        /// Hide the buy button for the first time
        buyButton.itemButton.isEnabled = false
        priceLabel.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.width.equalTo(70)
        }
        buyButton.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(122)
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
            button.setAccessibilityLabel("\(item.text) Section")
            button.setAccessibilityRole(.button)
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
        
        contentStack.wantsLayer = true
//        contentStack.layer?.borderColor = NSColor.red.cgColor
//        contentStack.layer?.borderWidth = 1
        
        contentStack.setViews([collectionViewContainer, sidebar], in: .top)
        self.view.addSubview(contentStack)
        
        contentStack.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.centerY.equalToSuperview()
            make.leading.equalTo(backButton.snp.leading)
            make.height.equalTo(544)
            make.width.equalTo(406)
        }
//        NSLayoutConstraint.activate([
//            contentStack.topAnchor.constraint(equalTo: self.view.topAnchor),
//            contentStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            contentStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
//        ])
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
//        collectionViewContainer.layer?.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            collectionViewContainer.widthAnchor.constraint(equalToConstant: 352),
            collectionViewContainer.heightAnchor.constraint(equalToConstant: 486)
        ])
    }
    
    func setupBackButton(){
        view.addSubview(backButton)

        backButton.action = #selector(backToMenu)
        backButton.target = self
        backButton.layer?.backgroundColor = .white
        backButton.setAccessibilityElement(true)
        backButton.setAccessibilityTitle("Back Button")
        backButton.setAccessibilityLabel("Back to Home Page from Shop Page")
        backButton.setAccessibilityRole(.button)
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(50)
        }

    }
    
    func setupPointsLabel() {
        
        let icon = CLSFSymbol(symbolName: "c.circle", description: "coins")
        icon.setConfiguration(size: 24, weight: .bold)
        icon.contentTintColor = .black
        
        points.backgroundColor = .clear
        points.setTextColor(.black)
        
        pointsView.wantsLayer = true
        
//        let blur = CLBlurEffectView(frame: pointsView.bounds)
//        
//        pointsView.addSubview(blur, positioned: .below, relativeTo: nil)
        
        pointsView.setViews([icon, points], in: .center)
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.orientation = .horizontal
        pointsView.alignment = .centerY
        pointsView.distribution = .equalSpacing
        pointsView.layer?.backgroundColor = .white
        pointsView.layer?.cornerRadius = 10
        pointsView.edgeInsets = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        pointsView.setAccessibilityElement(true)
        pointsView.setAccessibilityTitle("Your Points")
        pointsView.setAccessibilityLabel("Your current point is \(character?.point ?? 0)")
        pointsView.setAccessibilityRole(.group)
        
        view.addSubview(pointsView)
        
        pointsView.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(100)
            make.trailing.equalTo(collectionViewContainer.snp.trailing)
            make.top.equalTo(backButton.snp.top)
//            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
    }
    
    func highlightButton(_ button: TypeButton) {
        selectedButton?.isSelected = false
        selectedButton?.layer?.backgroundColor = NSColor.white.cgColor.copy(alpha: 0.7)
        selectedButton?.layer?.borderColor = .clear
        selectedButton?.layer?.borderWidth = 0
        selectedButton?.updateItemIcon(false)
        

        selectedButton = button
        selectedButton?.isSelected = true
        selectedButton?.layer?.backgroundColor = .white/*.copy(alpha: 0.84)*/ // Highlight color
        selectedButton?.layer?.borderColor = NSColor.cButton.cgColor
        selectedButton?.layer?.borderWidth = 4
        selectedButton?.updateItemIcon(true)
        
        priceLabel.setText("􀀈\(character?.headEquipment.price)")
        priceLabel.setAccessibilityTitle("Current equipment price is \(character?.headEquipment.price)")
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
            priceLabel.setText("􀀈\(character.headEquipment.price)")
            priceLabel.setAccessibilityTitle("Current equipment price is \(character.headEquipment.price)")
//            collectionViewContainer.updateItems(items: headItems)
//            buyButton.updateItemButtonPreview(item: currentHead, price: currentHead.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = currentHeadModel.isUnlocked
        case 1:
            itemType = .back
            updateData(with: .back)
            collectionViewContainer.selectCurrentItem(with: character.backEquipment)
            priceLabel.setText("􀀈\(character.backEquipment.price)")
            priceLabel.setAccessibilityTitle("Current equipment price is \(character.headEquipment.price)")
//            collectionViewContainer.updateItems(items: backItems)
//            buyButton.updateItemButtonPreview(item: currentBack, price: currentBack.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = currentBackModel.isUnlocked
        case 2:
            itemType = .hand
            updateData(with: .hand)
            collectionViewContainer.selectCurrentItem(with: character.handEquipment)
            priceLabel.setText("􀀈\(character.handEquipment.price)")
            priceLabel.setAccessibilityTitle("Current equipment price is \(character.headEquipment.price)")
//            collectionViewContainer.updateItems(items: handItems)
//            buyButton.updateItemButtonPreview(item: currentHand, price: currentHand.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = currentHandModel.isUnlocked
        case 3:
            itemType = .location
            updateData(with: .location)
            collectionViewContainer.selectCurrentItem(with: character.locationEquipment)
            priceLabel.setText("􀀈\(character.locationEquipment.price)")
            priceLabel.setAccessibilityTitle("Current equipment price is \(character.headEquipment.price)")
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
        
        buyButton.isHidden = false
    }
   
    func updateData(with type: EquipmentType = .head) {
        if let items = equipmentService?.getEquipments(equipmentType: type) {
            print("Ini items dari update data: \(items)")
            collectionViewContainer.updateItems(items: items)
        }
    }
    
    @objc func backToMenu(){
        pop()
    }
}
