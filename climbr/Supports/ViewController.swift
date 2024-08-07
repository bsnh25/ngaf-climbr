//
//  ViewController.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/08/24.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view                        = NSView()
        view.wantsLayer             = true
        view.layer?.backgroundColor = NSColor.systemPink.cgColor
        
        let label = NSTextField(labelWithString: "CLIMBR")
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

