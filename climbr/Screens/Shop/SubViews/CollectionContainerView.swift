//
//  CollectionContainerView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

protocol collectionContainerProtocol {
    func itemSelectedChangedWithType(to item: EquipmentItem, type: EquipmentType, isUnlocked: Bool)
    func updateCurrentItem(head: EquipmentItem, hand: EquipmentItem, back: EquipmentItem, location: EquipmentItem, isUnlocked: Bool, type: EquipmentType)
}

class CollectionContainerView: NSView {
    
    let collectionView: NSCollectionView
    
    var equipmentCollections: [EquipmentModel] = []
    
    private var selectedItemHead: GridItem?
    private var selectedItemBack: GridItem?
    private var selectedItemHand: GridItem?
    private var selectedItemLoc: GridItem?
    
    var collectionDelegate: collectionContainerProtocol?
    
    var currentHead: EquipmentItem?
    var currentBack: EquipmentItem?
    var currentHand: EquipmentItem?
    var currentLocation: EquipmentItem?
    
    var currentGridItem: GridItem?
//    var currentSelectedItem: EquipmentItem?
    
    override init(frame frameRect: NSRect) {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 90, height: 90)
        flowLayout.sectionInset = NSEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .vertical
        
        collectionView = NSCollectionView()
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(GridItem.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GridItem"))
        
        super.init(frame: frameRect)
        setupCollectionView()
        
        // Set the alpha value of the container view without affecting its subviews
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.8).cgColor
        self.layer?.cornerRadius = 20
        self.layer?.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self as? NSCollectionViewDelegate // If needed
        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.clear.cgColor
        
        collectionView.isSelectable = true
        collectionView.allowsEmptySelection = false
        collectionView.allowsMultipleSelection = false
        
        // Add the collectionView directly to the container view
        self.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints for the collection view
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    func updateItems(items: [EquipmentModel]) {
        equipmentCollections = items
        collectionView.reloadData()
    }
    
    func updateCurrentItem(head: EquipmentItem, hand: EquipmentItem, back: EquipmentItem, location: EquipmentItem) {
        self.currentHead = head
        self.currentHand = hand
        self.currentBack = back
        self.currentLocation = location
    }
    
    func updateCurrentGridItem(gridItem: GridItem) {
        self.currentGridItem = gridItem
    }
}

extension CollectionContainerView: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return equipmentCollections.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GridItem"), for: indexPath) as! GridItem
        item.configure(equipmentModel: equipmentCollections[indexPath.item])
        item.updateItemSelected(head: self.currentHead!, hand: self.currentHand!, back: self.currentBack!, location: self.currentLocation!)
        item.gridDelegate = self
        item.itemDelegate = self
        return item
    }
}

extension CollectionContainerView: gridItemSelectionProtocol {
    func gridItemSelectionDidChange(to newSelected: EquipmentItem, type: EquipmentType, isUnlocked: Bool) {
        switch type {
        case .head:
            currentHead = newSelected
        case .hand:
            currentHand = newSelected
        case .back:
            currentBack = newSelected
        case .location:
            currentLocation = newSelected
        }
//        print("di dalam collection view head: \(currentHead), hand: \(currentHand), back: \(currentBack), location: \(currentLocation)")
        
        collectionDelegate?.updateCurrentItem(head: currentHead!, hand: currentHand!, back: currentBack!, location: currentLocation!, isUnlocked: isUnlocked, type: type)
//        collectionDelegate?.itemSelectedChangedWithType(to: newSelected, type: type, isUnlocked: isUnlocked)
//        currentGridItem = newSelected
//        collectionDelegate?.itemSelectedChangedWithType(to: newSelected.item!, type: newSelected.type!)
    }
    
    func gridItemSelectionDidChange(to newSelected: GridItem) {
        switch newSelected.type {
        case .head:
            currentHead = newSelected.item
        case .hand:
            currentHand = newSelected.item
        case .back:
            currentBack = newSelected.item
        case .location:
            currentLocation = newSelected.item
        case .none:
            break
        }
        currentGridItem = newSelected
    }
}


extension CollectionContainerView: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        guard let indexPath = indexPaths.first,
              let cell = collectionView.item(at: indexPath) as? GridItem else {
            return
        }
    }
}

//cek di sini!!!!
extension CollectionContainerView: collectionItemProtocol {
    func collectionItemDidChange(to newSelected: EquipmentItem, type: EquipmentType, isUnlocked: Bool) {
        switch type {
        case .head:
            currentHead = newSelected
        case .hand:
            currentHand = newSelected
        case .back:
            currentBack = newSelected
        case .location:
            currentLocation = newSelected
        }
        
//        print("di dalam collection view head: \(currentHead), hand: \(currentHand), back: \(currentBack), location: \(currentLocation)")
        
        collectionDelegate?.updateCurrentItem(head: self.currentHead!, hand: self.currentHand!, back: self.currentBack!, location: self.currentLocation!, isUnlocked: isUnlocked, type: type)
    }
}
