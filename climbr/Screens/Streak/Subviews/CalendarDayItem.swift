//
//  CalendarDayItems.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 05/11/24.
//

import AppKit

class CalendarDayItem: NSCollectionViewItem {
    
    static let identifier = NSUserInterfaceItemIdentifier("CalendarDayItem")
    
    private let dayLabel: NSTextField = {
        let label = NSTextField(labelWithString: "")
        label.alignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override func loadView() {
        self.view = NSView()
        view.addSubview(dayLabel)
        view.wantsLayer = true
        view.layer?.borderColor = NSColor.red.cgColor
        view.layer?.borderWidth = 1
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configure(with day: Int?, isStreak: Bool, hasEvent: Bool) {
        if let day = day {
            dayLabel.stringValue = "\(day)"
            view.layer?.backgroundColor = isStreak ? NSColor.systemBlue.cgColor : (hasEvent ? NSColor.systemYellow.cgColor : NSColor.clear.cgColor)
            dayLabel.textColor = isStreak ? .white : .black
        } else {
            dayLabel.stringValue = ""
            view.layer?.backgroundColor = NSColor.clear.cgColor
        }
    }
}
