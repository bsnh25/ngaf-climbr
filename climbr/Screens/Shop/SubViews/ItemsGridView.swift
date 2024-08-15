//
//  ItemsGridView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

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
    
    let headItem: [String] = ["A", "B", "C", "D", "E"]
    let handItem: [String] = ["A", "B", "C", "D", "E", "F", "G"]
    let backItem: [String] = ["A", "B", "C", "D"]
    let locationItem: [String] = ["A", "B", "C", "D", "E", "F"]
    
    var itemType : EquipmentType = .head
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        
        collectionViewContainer.updateItems(items: headItem)
        setupSidebar()
        setupPointsLabel()
        setupCollectionViewContainer()
        horizontalStack()
    }
    
    func setupSidebar() {
        sidebar.orientation = .vertical
        sidebar.alignment = .leading
        sidebar.spacing = 10
        var items : [CustomButton] = []
        
        for (index, item) in sidebarItems.enumerated() {
            let button = CustomButton(imageName: item.imageName, text: item.text)
            button.tag = index
            button.target = self
            button.action = #selector(sidebarButtonClicked(_:))
            sidebar.addArrangedSubview(button)
            items.append(button)
        }
        
        sidebar.setViews(items, in: .top)
        sidebar.translatesAutoresizingMaskIntoConstraints = false
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
            contentStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10)
        ])
    }
        
    func createSidebarButton(title: String) -> NSButton {
        let button = NSButton(title: title, target: nil, action: nil)
        button.isBordered = false
        button.font = NSFont.systemFont(ofSize: 16)
        button.alignment = .left
        return button
    }
        
    func setupCollectionViewContainer() {
        collectionViewContainer.itemType = itemType
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionViewContainer.widthAnchor.constraint(equalToConstant: 350),
            collectionViewContainer.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
    
    
        
    func setupPointsLabel() {
        view.addSubview(points)
        points.setText("halo")
        NSLayoutConstraint.activate([
            points.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            points.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
    }
    
    @objc func sidebarButtonClicked(_ sender: CustomButton) {
        print("halo \(sender.tag)")
        switch sender.tag {
        case 0:
            print("case 0")
            collectionViewContainer.updateItems(items: headItem)
        case 1:
            print("case 1")
            collectionViewContainer.updateItems(items: backItem)
        case 2:
            print("case 2")
            collectionViewContainer.updateItems(items: handItem)
        case 3:
            print("case 3")
            collectionViewContainer.updateItems(items: locationItem)
        default:
            break
        }
    }
}
