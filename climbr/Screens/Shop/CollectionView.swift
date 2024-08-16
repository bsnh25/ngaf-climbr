////
////  CollectionView.swift
////  climbr
////
////  Created by Fatakhillah Khaqo on 14/08/24.
////
//
//import Cocoa
//
//class CollectionView: NSView {
//    private var images: [NSImage] = []
//    
//    private let collectionView: NSCollectionView = {
//        let layout = NSCollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        
//        let collectionView = NSCollectionView(frame: .zero)
//        collectionView.collectionViewLayout = layout
////        collectionView.backgroundColor = .systemBackground
////        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
//        collectionView.register(CustomCollectionViewCell.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier("CustomCollectionViewCell"))
////        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
////        collectionView.alwaysBounceVertical = false
////        collectionView.alwaysBounceHorizontal = false
//        
//        return collectionView
//    }()
//    
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frame)
//        self.setupUI()
//        for _ in 0...25 {
//            images.append(NSImage(named: "1")!)
//            images.append(NSImage(named: "2")!)
//            images.append(NSImage(named: "3")!)
//            images.append(NSImage(named: "4")!)
//        }
//        
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        self.setupUI()
////        
////        for _ in 0...25 {
////            images.append(UIImage(named: "1")!)
////            images.append(UIImage(named: "2")!)
////            images.append(UIImage(named: "3")!)
////            images.append(UIImage(named: "4")!)
////        }
////        
////        self.collectionView.dataSource = self
////        self.collectionView.delegate = self
////    }
//
//    private func setupUI(){
////        self.view.backgroundColor = .systemBlue
//        
//        self.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//        ])
//    }
//}
//
////extension CollectionView: NSCollectionViewDelegate, NSCollectionViewDataSource {
////    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
////        return self.images.count
////    }
////    
////    func collectionView(_ collectionView: NSCollectionView, cellForItemAt indexPath: IndexPath) -> NSCollectionViewItem {
////        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
////            fatalError("Failed to deque CustomCollectionViewCell in HomeController")
////        }
////        
////        let image = self.images[indexPath.row]
////        cell.configure(with: image)
////        
////        return cell
////    }
////}
//
//extension CollectionView: NSCollectionViewDelegate, NSCollectionViewDataSource {
//    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
//        
//        let image = self.images[1]
//        
//    }
//    
//    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.images.count
//    }
//    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else {
////            fatalError("Failed to deque CustomCollectionViewCell in HomeController")
////        }
////        
////        let image = self.images[indexPath.row]
////        cell.configure(with: image)
////        
////        return cell
////    }
////}
