//
//  CollectionContainerView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class CollectionContainerView: NSView {
    
    let collectionView: NSCollectionView
    
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
        
        setupCollectionView()
        self.wantsLayer = true
        self.layer?.cornerRadius = 20 // Adjust the corner radius as needed
        self.layer?.masksToBounds = true
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupCollectionView() {
        collectionView.dataSource = self
        
        let scrollView = NSScrollView()
        scrollView.documentView = collectionView
        scrollView.hasVerticalScroller = false
        scrollView.hasHorizontalScroller = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(scrollView)
            
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension CollectionContainerView: NSCollectionViewDataSource {
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionName.count
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "GridItem"), for: indexPath) as! GridItem
        item.textLabel.stringValue = collectionName[indexPath.item]
        return item
    }
}
