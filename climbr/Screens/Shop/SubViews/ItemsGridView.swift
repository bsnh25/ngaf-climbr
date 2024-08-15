//
//  ItemsGridView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

//class ItemsGridView: NSView {
//    
//}

class ItemsGridVC: NSViewController {
    
    let pointsLabel = NSTextField(labelWithString: "100")
    let collectionViewContainer = CollectionContainerView()
    let sidebar = NSStackView()
    let contentStack = NSStackView()
    let points  = CLLabel(fontSize: 18, fontWeight: .bold)
    
    let sidebarItems: [(imageName: String, text: String)] = [
            ("person.fill", "Headgear"),
            ("bag.fill", "Backpack"),
            ("figure.walk", "Hiking stick"),
            ("map.fill", "Location")
        ]
    
    var itemType : EquipmentType = .head
    
//    let sidebarItems = ["Headgear", "Backpack", "Hiking stick", "Location"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        
        setupSidebar()
        setupPointsLabel()
        setupCollectionViewContainer()
        horizontalStack()
    }
    
    func horizontalStack(){
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.orientation = .horizontal
        contentStack.alignment = .top
        contentStack.spacing = 10
        
        contentStack.setViews([sidebar, collectionViewContainer], in: .top)
        self.view.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            contentStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
    }
        
    func setupSidebar() {
//        let sidebar = NSStackView()
        sidebar.orientation = .vertical
        sidebar.alignment = .leading
//        sidebar.distribution = .fillEqually
        sidebar.spacing = 10
        
        let items = sidebarItems.map { item in
            CustomButton(imageName: item.imageName, text: item.text)
        }
        
        sidebar.setViews(items, in: .top)
        
//        for item in sidebarItems {
////            let button = CustomButton(frame: NSRect(x: 0, y: 0, width: 300, height: 300))
////            button.setButton(imageName: item.imageName, text: item.text)
////            let button = CustomButton(height: 0, width: 0, imageName: item.imageName, text: item.text)
//            let button = CustomButton(imageName: item.imageName, text: item.text)
//            sidebar.addArrangedSubview(button)
//        }
        
//        view.addSubview(sidebar)
        
        sidebar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            sidebar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            sidebar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
////            sidebar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
////            sidebar.trailingAnchor.constraint(equalTo: collectionViewContainer.leadingAnchor , constant: 20)
//        ])
    }
        
    func createSidebarButton(title: String) -> NSButton {
        let button = NSButton(title: title, target: nil, action: nil)
        button.isBordered = false
        button.font = NSFont.systemFont(ofSize: 16)
        button.alignment = .left
        return button
    }
        
    func setupCollectionViewContainer() {
//        let collectionViewContainer = CollectionContainerView()
        
//        view.addSubview(collectionViewContainer)
        collectionViewContainer.itemType = itemType
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
//        collectionViewContainer.layer?.backgroundColor = .white
        
        NSLayoutConstraint.activate([
//                collectionViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            collectionViewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            collectionViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionViewContainer.widthAnchor.constraint(equalToConstant: 350),
            collectionViewContainer.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
        
    func setupPointsLabel() {
        
        view.addSubview(points)
        points.setText("halo")
//        pointsLabel.font = NSFont.systemFont(ofSize: 20)
//        pointsLabel.alignment = .right
//        view.addSubview(pointsLabel)
            
//        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            pointsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            pointsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
//        ])
        NSLayoutConstraint.activate([
            points.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            points.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
    }
}
