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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(dayLabel)
    view.wantsLayer = true
    
    dayLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  func configure(with day: Int?, isStreak: Bool = false, hasEvent: Bool = false) {
    
    if let day {
      dayLabel.stringValue = "\(day)"
    } else {
      dayLabel.stringValue = ""
    }
    
    dayLabel.textColor = isStreak ? .white : .black
    
    view.layer?.backgroundColor = (isStreak ? NSColor.cNewButton : NSColor.white).cgColor
  }
}

#Preview(traits: .defaultLayout, body: {
  CalendarDayItem()
})
