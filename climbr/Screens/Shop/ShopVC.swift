//
//  ShopVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Cocoa

class ShopVC: NSViewController {
    let itemNameLabel = NSTextField(labelWithString: "Climber's Crown")
    let buyButton = NSButton(title: "Buy for 100", target: nil, action: nil)
    let headgearButton = NSButton(title: "Headgear", target: nil, action: nil)
    let backpackButton = NSButton(title: "Backpack", target: nil, action: nil)
    let hikingStickButton = NSButton(title: "Hiking stick", target: nil, action: nil)
    let locationButton = NSButton(title: "Location", target: nil, action: nil)
    let itemButtons = (0..<12).map { _ in NSButton(image: NSImage(named: NSImage.lockLockedTemplateName)!, target: nil, action: nil) }
    let coinsLabel = NSTextField(labelWithString: "100")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor

        // Item name label
        itemNameLabel.font = NSFont.systemFont(ofSize: 18, weight: .medium)
        itemNameLabel.alignment = .center

        // Buy button
        buyButton.bezelStyle = .rounded
        buyButton.font = NSFont.systemFont(ofSize: 15)
        buyButton.isBordered = true

        // Sidebar buttons
        let sidebarStackView = NSStackView(views: [headgearButton, backpackButton, hikingStickButton, locationButton])
        sidebarStackView.orientation = .vertical
        sidebarStackView.distribution = .fillEqually
        sidebarStackView.spacing = 20

        // Items grid
        let itemsGrid = NSGridView(views: [
            Array(itemButtons[0..<4]),
            Array(itemButtons[4..<8]),
            Array(itemButtons[8..<12])
        ])
        itemsGrid.rowSpacing = 20
        itemsGrid.columnSpacing = 20

        // Coins label
        coinsLabel.font = NSFont.systemFont(ofSize: 15)

            // Layout
        let mainStackView = NSStackView(views: [sidebarStackView, itemsGrid])
        mainStackView.orientation = .horizontal
        mainStackView.spacing = 30
        mainStackView.distribution = .fillEqually

        let mainView = NSStackView(views: [itemNameLabel, buyButton, mainStackView, coinsLabel])
        mainView.orientation = .vertical
        mainView.spacing = 20
        mainView.distribution = .fillProportionally

        view.addSubview(mainView)

            // Constraints
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.widthAnchor.constraint(equalToConstant: 600),
            mainView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}
