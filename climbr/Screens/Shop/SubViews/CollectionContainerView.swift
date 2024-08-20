//
//  CollectionContainerView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

protocol collectionContainerProtocol {
    func itemSelectedChanged(to item: EquipmentItem, type: EquipmentType)
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
        collectionView.delegate   = self
        
        collectionView.dataSource = self
        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = .white
        
        collectionView.isSelectable = true
        collectionView.allowsMultipleSelection = false
        collectionView.allowsEmptySelection = false
        
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
    
    func selectedItem(item: EquipmentItem) {
        print(equipmentCollections)
        if let indexel = equipmentCollections.firstIndex(where: { data in
            data.item == item
        }) {
            print("Index: ", indexel)
            let index: Set<IndexPath> = [IndexPath(item: indexel, section: 0)]
            collectionView.selectItems(at: index, scrollPosition: .centeredHorizontally)
        }
        
        
    }
}

extension CollectionContainerView: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return equipmentCollections.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GridItem"), for: indexPath) as! GridItem
        
        item.configure(equipmentModel: equipmentCollections[indexPath.item])
        
        return item
    }
    
    
}

extension CollectionContainerView: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        guard let indexPath = indexPaths.first,
              let cell = collectionView.item(at: indexPath) as? GridItem else {
            return
        }
    
        
        if let item = cell.item, let type = cell.type {
            collectionDelegate?.itemSelectedChanged(to: item, type: type)
        }
    }
}

