//
//  AssetGridView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class AssetGridView: NSView {
    let flowLayout = NSCollectionViewFlowLayout()
    
    func setupCollectionView(){
        
    }
}

//class AssetGridView: NSView{
//    
//    private var assets: [AssetItemView] = []
//    
//    private let collectionView: NSCollectionView = {
//        let layout = NSCollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        
//        let collectionView = NSCollectionView(frame: .zero)
//        collectionView.collectionViewLayout = layout
//        collectionView.register(CustomCollectionViewCell.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("CustomCollectionViewItem"))
//        
//        return collectionView
//    }()
//
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frameRect)
////        setupCollectionView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
////        setupCollectionView()
//    }
//    
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//
//        // Drawing code here.
//    }
//    
////    init() {
////        self.collectionView.dataSource = self
////        self.collectionView.delegate = self
////        super.init()
////    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI(){
//        addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ])
//    }
//    
//}
//
//
////extension AssetGridView: NSCollectionViewDataSource, NSCollectionViewDelegate {
//////    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
//////
//////    }
//////    
//////    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
//////        
//////    }
////}
////import Cocoa
////
////class ViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate {
////
////    var collectionView: NSCollectionView!
////    var dataSource: [String] = ["Item 1", "Item 2", "Item 3"]  // Example data source
////
////    override func viewDidLoad() {
////        super.viewDidLoad()
////
////        // Initialize Layout
////        let layout = NSCollectionViewFlowLayout()
////        layout.itemSize = NSSize(width: 100, height: 100)
////        layout.sectionInset = NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
////        layout.minimumLineSpacing = 10
////        layout.minimumInteritemSpacing = 10
////        
////        // Initialize Collection View
////        collectionView = NSCollectionView(frame: self.view.bounds)
////        collectionView.collectionViewLayout = layout
////        collectionView.register(CustomCollectionViewCell.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("MyCollectionViewItem"))
////        collectionView.dataSource = self
////        collectionView.delegate = self
////        
////        // Customize appearance
////        collectionView.backgroundColors = [NSColor.white]
////        
////        // Add the Collection View to the view hierarchy
////        self.view.addSubview(collectionView)
////    }
////
////    // MARK: NSCollectionViewDataSource
////
////    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
////        return dataSource.count
////    }
////
////    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
////        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("MyCollectionViewItem"), for: indexPath)
////        
////        guard let collectionViewItem = item as? MyCollectionViewItem else { return item }
////        
////        // Configure the item
////        collectionViewItem.textField?.stringValue = dataSource[indexPath.item]
////        
////        return collectionViewItem
////    }
////    
////    // MARK: NSCollectionViewDelegate
////    
////    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
////        guard let indexPath = indexPaths.first else { return }
////        print("Selected item at \(indexPath.item)")
////    }
////}
