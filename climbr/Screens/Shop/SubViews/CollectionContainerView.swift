//
//  CollectionContainerView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class CollectionContainerView: NSView {
    
    let collectionView: NSCollectionView
    
    var collectionItems: [EquipmentModel] = []
    
    var itemsHead: [EquipmentModel] = []
    var itemsBackPack: [EquipmentModel] = []
    var itemsHikingStick: [EquipmentModel] = []
    var itemsLocation: [EquipmentModel] = []
    
    var itemType : EquipmentType = .head
    
    var collectionName : [String] = []
    
    var equipmentCollections : [EquipmentModel] = []
        
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
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 20
        self.layer?.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = .white
        
        let scrollView = NSScrollView()
        scrollView.documentView = collectionView
        scrollView.verticalScrollElasticity = .none
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(scrollView)
            
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func updateItems(items: [String]) {
        collectionName = items
        collectionView.reloadData()
    }
    
    func updateItems(items: [EquipmentModel]) {
        equipmentCollections = items
        collectionView.reloadData()
    }
}

extension CollectionContainerView: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return equipmentCollections.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GridItem"), for: indexPath) as! GridItem
        item.configure(text: equipmentCollections[indexPath.item].name, backgroundImage: NSImage(named: equipmentCollections[indexPath.item].image))
        return item
    }
}
