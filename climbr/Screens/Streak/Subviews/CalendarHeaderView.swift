//
//  CalendarHeaderView.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 08/11/24.
//

import Cocoa

class CalendarHeaderView: NSStackView {
  
  private let calendar = Calendar.current
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    
    return formatter
  }()
  
  
  private var currentMonth: Date = .now
  
  private lazy var titleLabel: CLTextLabelV2 = {
    let label = CLTextLabelV2(sizeOfFont: 15, weightOfFont: .semibold, contentLabel: dateFormatter.string(from: currentMonth))
    
    return label
  }()
  
  init() {
    super.init(frame: .zero)
    configure()
  }
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)
    
  }
  
  var onPreviousMonth: ((Date) -> Void)?
  var onNextMonth: ((Date) -> Void)?
  
  private func configure() {
    
    let previousIcon = NSImage(systemSymbolName: "chevron.left", accessibilityDescription: "Previous Month")!
    previousIcon.withSymbolConfiguration(.init(pointSize: 15, weight: .semibold))
    
    let previousButton = CLTextButtonV2(
      image: previousIcon,
      target: self,
      action: #selector(previousMonth)
    )
    
    let nextIcon = NSImage(systemSymbolName: "chevron.right", accessibilityDescription: "Next Month")!
    nextIcon.withSymbolConfiguration(.init(pointSize: 15, weight: .semibold))
    
    let nextButton = CLTextButtonV2(
      image: nextIcon,
      target: self,
      action: #selector(nextMonth)
    )
    
    addArrangedSubview(previousButton)
    addArrangedSubview(titleLabel)
    addArrangedSubview(nextButton)
    
    orientation = .horizontal
    alignment = .centerY
    distribution = .equalSpacing
    
  }
  
  @objc private func previousMonth(_ sender: NSButton) {
    currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth)!
    
    titleLabel.stringValue = dateFormatter.string(from: currentMonth)
    
    onPreviousMonth?(currentMonth)
  }
  
  @objc private func nextMonth(_ sender: NSButton) {
    currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth)!
    
    titleLabel.stringValue = dateFormatter.string(from: currentMonth)
    
    onNextMonth?(currentMonth)
  }
}

#Preview(traits: .defaultLayout, body: {
  CalendarHeaderView()
})
