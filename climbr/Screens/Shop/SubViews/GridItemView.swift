//
//  GridItemView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class GridItem: NSCollectionViewItem {
    let textLabel = NSTextField(labelWithString: "")
    
    override func loadView() {
        self.view = NSView()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.view.layer?.cornerRadius = 10
        
        textLabel.font = NSFont.systemFont(ofSize: 20)
        textLabel.alignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
