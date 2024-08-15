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
    
    let collectionName : [String] = [
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I"
    ]
        
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
        
        setupDisplayItems()
        setupCollectionView()
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 20 // Adjust the corner radius as needed
        self.layer?.masksToBounds = true
//        self.layer?.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.wantsLayer = true
        collectionView.layer?.backgroundColor = .clear
//        collectionView.layer?.backgroundColor = .white
        
        let scrollView = NSScrollView()
        scrollView.documentView = collectionView
        scrollView.hasVerticalScroller = false
        scrollView.hasHorizontalScroller = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.wantsLayer = true
//        scrollView.layer?.backgroundColor = .white
//        scrollView.backgroundColor = .white
        
        self.addSubview(scrollView)
            
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupDisplayItems(){
        for head in Headgear.allCases {
            collectionItems.append(
                EquipmentModel(id: UUID(), image: head.image, isUnlocked: false, name: head.rawValue, price: head.harga, type: .head)
            )
        }
        
        for stick in HikingStick.allCases {
            collectionItems.append(
                EquipmentModel(id: UUID(), image: stick.image, isUnlocked: false, name: stick.rawValue, price: stick.harga, type: .hand)
            )
        }
        
        for back in Backpack.allCases {
            collectionItems.append(
                EquipmentModel(id: UUID(), image: back.image, isUnlocked: false, name: back.rawValue, price: back.harga, type: .back)
            )
        }
        
        for loc in Location.allCases {
            collectionItems.append(
                EquipmentModel(id: UUID(), image: loc.image, isUnlocked: false, name: loc.rawValue, price: loc.harga, type: .back)
            )
            
        }
        
//        switch equipment {
//        case .head:
//            for head in Headgear.allCases {
//                collectionItems.append(
//                    EquipmentModel(id: UUID(), image: head.image, isUnlocked: false, name: head.rawValue, price: head.harga, type: .head)
//                )
//            }
//        case .hand:
//            for stick in HikingStick.allCases {
//                collectionItems.append(
//                    EquipmentModel(id: UUID(), image: stick.image, isUnlocked: false, name: stick.rawValue, price: stick.harga, type: .hand)
//                )
//            }
//        case .back:
//            for back in Backpack.allCases {
//                collectionItems.append(
//                    EquipmentModel(id: UUID(), image: back.image, isUnlocked: false, name: back.rawValue, price: back.harga, type: .back)
//                )
//            }
//        case .location:
//            for loc in Location.allCases {
//                collectionItems.append(
//                    EquipmentModel(id: UUID(), image: loc.image, isUnlocked: false, name: loc.rawValue, price: loc.harga, type: .back)
//                )
//                
//            }
//        }
    }
}

extension CollectionContainerView: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionName.count
//        switch itemType {
//        case .head:
//            print("head: ",itemsHead.count)
//            return itemsHead.count
//            
//        case .hand:
//            print(itemsHikingStick.count)
//            return itemsHikingStick.count
//            
//        case .back:
//            print(itemsBackPack.count)
//            return itemsBackPack.count
//            
//        case .location:
//            print(itemsLocation.count)
//            return itemsLocation.count
//            
//        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GridItem"), for: indexPath) as! GridItem
        item.textLabel.stringValue = collectionName[indexPath.item]
//        switch itemType {
//        case .head:
//            item.textLabel.stringValue = itemsHead[indexPath.item].name
//        case .hand:
//            item.textLabel.stringValue = itemsHikingStick[indexPath.item].name
//        case .back:
//            item.textLabel.stringValue = itemsBackPack[indexPath.item].name
//        case .location:
//            item.textLabel.stringValue = itemsLocation[indexPath.item].name
//        }
        
        return item
    }
}
