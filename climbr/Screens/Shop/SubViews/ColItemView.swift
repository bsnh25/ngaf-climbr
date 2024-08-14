//
//  ColItemView.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class ItemView: NSView {

    let buttonSize: NSSize = NSSize(width: 100, height: 20)
    let itemSize: NSSize = NSSize(width: 120, height: 40)
    let buttonOrigin: NSPoint = NSPoint(x: 10, y: 10)

    var button: NSButton?

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: NSRect(origin: frameRect.origin, size: itemSize))
        let newButton = NSButton(frame: NSRect(origin: buttonOrigin, size: buttonSize))
//        newButton.bezelStyle = NSBezelStyle.RoundedBezelStyle
        self.addSubview(newButton)
        self.button = newButton;
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setButtonTitle(title: String) {
        self.button!.title = title
    }
}
