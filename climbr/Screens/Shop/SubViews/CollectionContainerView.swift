//
//  CollectionContainerView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

protocol collectionContainerProtocol {
    func itemSelectedChanged(to newSelected: EquipmentItem)
}

class CollectionContainerView: NSView {
    
    let collectionView: NSCollectionView
    
    var equipmentCollections : [EquipmentModel] = []
    
    private var selectedItemHead: GridItem?
    private var selectedItemBack: GridItem?
    private var selectedItemHand: GridItem?
    private var selectedItemLoc: GridItem?
    
    var collectionDelegate: collectionContainerProtocol?
        
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
        item.configure(equipmentModel: equipmentCollections[indexPath.item])
        item.gridDelegate = self
        return item
    }
}

extension CollectionContainerView : gridItemSelectionProtocol {
    func gridItemSelectionDidChange(to newSelected: GridItem) {
        print(newSelected.item?.rawValue ?? 0)
        collectionDelegate?.itemSelectedChanged(to: newSelected.item ?? .climberCrownHG)
    }
}

