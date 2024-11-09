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
  
  func applySpecificRoundedCorners(corners: CACornerMask, radius: CGFloat) {
    // Ensure the view has a layer
    guard let layer = self.view.layer else { return }
    
    // Apply corner radius and mask to specific corners
    layer.cornerRadius = radius
    layer.maskedCorners = corners
  }
  
  func configure(
    with day: Int?,
    isStreak: Bool = false,
    hasEvent: Bool = false,
    isFirst: Bool = false,
    isLast: Bool = false,
    radius: CGFloat = 0
  ) {
    
    if let day {
      dayLabel.stringValue = "\(day)"
    } else {
      dayLabel.stringValue = ""
    }
    
    if isFirst && isLast {
      applySpecificRoundedCorners(
        corners: [
          .layerMinXMaxYCorner,
          .layerMinXMinYCorner,
          .layerMaxXMinYCorner,
          .layerMaxXMaxYCorner
        ],
        radius: radius
      )
    } else if isFirst {
      applySpecificRoundedCorners(corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner], radius: radius)
    } else if isLast {
      applySpecificRoundedCorners(corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: radius)
    }
    
    dayLabel.textColor = isStreak ? .white : .black
    
    view.layer?.backgroundColor = (isStreak ? NSColor.cNewButton : NSColor.white).cgColor
  }
}

#Preview(traits: .defaultLayout, body: {
  CalendarDayItem()
})
