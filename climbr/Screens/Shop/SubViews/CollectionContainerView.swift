//
//  CollectionContainerView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa
import AppKit
import SnapKit

protocol CollectionContainerProtocol: AnyObject {
    func itemSelectedChangedWithType(to data: EquipmentModel)
}

class CollectionContainerView: NSView {
    
    let collectionView: NSCollectionView
    
    var equipmentCollections: [EquipmentModel] = []
    
    let scrollView: NSScrollView
    let titleItems: CLLabel
    let verticalStack : NSStackView
    let HOutterStack: NSStackView = NSStackView()
    let VMiddleStack : NSStackView = NSStackView()
    let HInnerStack: NSStackView = NSStackView()
    let HImageView: NSImageView = {
        let imageView = NSImageView()
        imageView.image = NSImage(systemSymbolName: "xbox.logo", accessibilityDescription: "Coba")
        imageView.imageScaling = .scaleAxesIndependently
        return imageView
    }()
    let hView: HView = HView()
    
    weak var collectionDelegate: CollectionContainerProtocol?
    
    override init(frame frameRect: NSRect) {
        
        titleItems = CLLabel(fontSize: 22, fontWeight: .bold)
        titleItems.stringValue = "Title Here" // Ganti dengan teks yang diinginkan
        titleItems.alignment = .center
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 80, height: 80)
        flowLayout.sectionInset = NSEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        //        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .vertical
        
        collectionView = NSCollectionView()
        collectionView.wantsLayer = true
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(GridItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GridItem"))
        
        scrollView = NSScrollView()
        scrollView.documentView = collectionView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.wantsLayer = true
        scrollView.layer?.backgroundColor = .black
        
        verticalStack = NSStackView()
        //        verticalStack.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.72).cgColor
        super.init(frame: frameRect)
        setupCollectionView()
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 10
        self.layer?.masksToBounds = true
        self.layer?.backgroundColor = .white
        self.layer?.borderColor = NSColor.red.cgColor
        self.layer?.borderWidth = 1
        
        setupConstraints()
        configOutterStack()
        configMiddleStack()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self // If needed
        collectionView.wantsLayer = true
        collectionView.backgroundColors = [.clear]
        collectionView.isSelectable = true
        collectionView.allowsEmptySelection = false
        collectionView.allowsMultipleSelection = false
        // Tambahkan titleItems ke verticalStack
//        verticalStack.addArrangedSubview(titleItems)
//        verticalStack.addArrangedSubview(scrollView) // Tambah scrollView setelah titleItems
        
        

        self.addSubview(verticalStack)
        
    }
    
    private func setupConstraints() {
        HOutterStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        verticalStack.orientation = .vertical
        verticalStack.alignment = .leading
        verticalStack.spacing = 10
        let views = [HOutterStack, scrollView]
        verticalStack.setViews(views, in: .top)
        
        verticalStack.wantsLayer = true
        verticalStack.layer?.backgroundColor = .clear
//        verticalStack.layer?.borderColor = NSColor.yellow.cgColor
//        verticalStack.layer?.borderWidth = 1
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
//            make.width.height.equalToSuperview()
        }
        
        HOutterStack.snp.makeConstraints { make in
            make.width.equalTo(312)
            make.height.equalTo(110)
        }
        
        scrollView.snp.makeConstraints { make in
            make.width.height.equalTo(312)
        }
    }
    
    private func configOutterStack() {
        HOutterStack.orientation = .horizontal
        HOutterStack.spacing = 20
        let views = [hView, VMiddleStack]
        HOutterStack.setViews(views, in: .center)
        
        HOutterStack.wantsLayer = true
//        HOutterStack.layer?.borderColor = NSColor.cButton.cgColor
//        HOutterStack.layer?.borderWidth = 1
        
        hView.wantsLayer = true
//        hView.layer?.borderColor = NSColor.blue.cgColor
//        hView.layer?.borderWidth = 5
        
        hView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
//            make.leading.equalTo(HOutterStack.snp.leading)
//            make.top.equalTo(HOutterStack.snp.top)
        }
        
        VMiddleStack.snp.makeConstraints { make in
//            make.leading.equalTo(HImageView.snp.trailing)
//            make.trailing.equalTo(HOutterStack.snp.trailing)
//            make.verticalEdges.equalTo(HOutterStack.snp.verticalEdges).offset(17)
//            make.centerY.equalTo(HImageView.snp.centerY)
            make.width.equalTo(188)
            make.height.equalTo(76)
        }
    }
    
    private func configMiddleStack() {
        VMiddleStack.orientation = .vertical
        VMiddleStack.spacing = 12
        VMiddleStack.addArrangedSubview(titleItems)
        VMiddleStack.addArrangedSubview(HInnerStack)
        
        VMiddleStack.wantsLayer = true
//        VMiddleStack.layer?.borderColor = NSColor.cButton.cgColor
//        VMiddleStack.layer?.borderWidth = 2
        
        HInnerStack.wantsLayer = true
//        HInnerStack.layer?.borderColor = .black
//        HInnerStack.layer?.borderWidth = 2
        HInnerStack.spacing = 12
        HInnerStack.alignment = .centerY
        
        
        titleItems.snp.makeConstraints { make in
//            make.height.equalTo(30)
//            make.width.equalTo(30)
//            make.horizontalEdges.equalTo(VMiddleStack.snp.horizontalEdges)
        }
        
        HInnerStack.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(188)
//            make.horizontalEdges.equalTo(VMiddleStack.snp.horizontalEdges)
        }
        
        
        
    }
    
    func updateItems(items: [EquipmentModel]) {
        equipmentCollections = items
        titleItems.setText("\(equipmentCollections[0].item.name)")
        titleItems.setAccessibilityRole(.staticText)
        titleItems.setAccessibilityTitle("\(equipmentCollections[0].item.name) Equipment")
        //        collectionView.setAccessibilityRole(.cell)
        //        collectionView.setAccessibilityLabel("\(equipmentCollections[0].item.name) Equipment")
        collectionView.reloadData()
    }
}

extension CollectionContainerView: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return equipmentCollections.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GridItem"), for: indexPath) as! GridItem
        item.configure(equipmentModel: equipmentCollections[indexPath.item])
//        hView.configure(equipmentModel: equipmentCollections[indexPath.item])
        
        item.view.setAccessibilityElement(true)
        item.view.setAccessibilityLabel("\(equipmentCollections[indexPath.item].item.name) Equipment is \(equipmentCollections[indexPath.item].isUnlocked ? "Item is Unlocked" : "Item is Locked")")
        item.view.setAccessibilityRole(.cell)
        return item
    }
    
}


class HView: NSView{
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
        view.layer?.backgroundColor = NSColor.lightGray.cgColor.copy(alpha: 0.8)
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
    
    var data: EquipmentModel?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.8).cgColor
        self.layer?.cornerRadius = 10
        
        lockIcon.setConfiguration(size: 24, weight: .bold)
        lockIcon.contentTintColor = .black
        
        addSubview(backgroundImageView)
        addSubview(overlayView)
        addSubview(lockIcon)
        addSubview(borderView)
        
        borderView.layer?.borderColor = NSColor.darkGray.cgColor
        borderView.layer?.borderWidth = 2
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().inset(10)
        }
        
        overlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lockIcon.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(text: String, backgroundImage: NSImage?) {
        backgroundImageView.image = backgroundImage
    }

    func configure(equipmentModel: EquipmentModel) {
        backgroundImageView.image = NSImage(named: equipmentModel.item.image)
        data = equipmentModel
        overlayView.isHidden = equipmentModel.isUnlocked
        lockIcon.isHidden = equipmentModel.isUnlocked
//        overlayView.setAccessibilityLabel("\(equipmentModel.isUnlocked ? "Item is Unlocked" : "Item is Locked")")
//        backgroundImageView.setAccessibilityLabel("\(equipmentModel.item.itemName) Equipment Picture")
//        lockIcon.setAccessibilityLabel("\(equipmentModel.isUnlocked ? "Item is Unlocked" : "Item is Locked")")
    }
}
