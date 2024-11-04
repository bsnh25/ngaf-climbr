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
    var verticalStack : NSStackView
    
    weak var collectionDelegate: CollectionContainerProtocol?
    
    override init(frame frameRect: NSRect) {
        
        titleItems = CLLabel(fontSize: 26, fontWeight: .bold)
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
        verticalStack.orientation = .vertical
        verticalStack.spacing = 10
        verticalStack.addArrangedSubview(titleItems)
        verticalStack.addArrangedSubview(scrollView)
        
        verticalStack.wantsLayer = true
        verticalStack.layer?.backgroundColor = .clear
        //        verticalStack.layer?.backgroundColor = NSColor.white.withAlphaComponent(0.72).cgColor
        super.init(frame: frameRect)
        setupCollectionView()
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 10
        self.layer?.masksToBounds = true
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self // If needed
        collectionView.wantsLayer = true
//        collectionView.backgroundColors = [.white.withAlphaComponent(0.72)]
        collectionView.backgroundColors = [.clear]
        collectionView.isSelectable = true
        collectionView.allowsEmptySelection = false
        collectionView.allowsMultipleSelection = false
        
        //        collectionView.layer?.borderColor = NSColor.red.cgColor
        //        collectionView.layer?.borderWidth = 1
        
        // Add the collectionView directly to the container view
        //        self.addSubview(collectionView)
        self.addSubview(verticalStack)
        
        //        let blur = CLBlurEffectView(frame: self.bounds)
        //        collectionView.backgroundView = blur
        
    }
    
    private func setupConstraints() {
        titleItems.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //
        //        verticalStack.blendingMode = .withinWindow
        //        verticalStack.material     = .hudWindow
        ////        appearance   = NSAppearance(named: .vibrantLight)
        //
        //        verticalStack.state        = .active
        
        verticalStack.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.snp.verticalEdges)
            make.horizontalEdges.equalTo(self.snp.horizontalEdges)
        }
        
        NSLayoutConstraint.activate([
            // Atur constraint untuk titleItems agar berada di atas scrollView
            titleItems.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            titleItems.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            titleItems.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            // Atur scrollView agar berada di bawah titleItems
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: titleItems.bottomAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
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
        item.view.setAccessibilityElement(true)
        item.view.setAccessibilityLabel("\(equipmentCollections[indexPath.item].item.name) Equipment is \(equipmentCollections[indexPath.item].isUnlocked ? "Item is Unlocked" : "Item is Locked")")
        item.view.setAccessibilityRole(.cell)
//        item.backgroundImageView.setAccessibilityTitle("\(equipmentCollections[indexPath.item].item.name)")
        return item
    }
    
}
