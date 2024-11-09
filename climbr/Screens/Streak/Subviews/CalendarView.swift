//
//  CalendarView.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 05/11/24.
//
import Cocoa
import AppKit
import SnapKit


class CalendarView: NSStackView {
  struct CalendarDay {
    var date: Date?
    var dayNumber: Int?
    var isCurrentMonth: Bool = false
  }
  
  var days: [CalendarDay] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  var streakDays: [Streak] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  var currentMonth: Date = .now
  
  private let calendarHeaderView = CalendarHeaderView()
  
  let availableWidth = 316 - 40
  
  private lazy var collectionView: NSCollectionView = {
    let collectionView = NSCollectionView()
    let layout = NSCollectionViewFlowLayout()
    let itemWidth = availableWidth / 6
    
    layout.itemSize = NSSize(width: itemWidth, height: itemWidth)
    layout.minimumInteritemSpacing = -4
    layout.minimumLineSpacing = 8
    
    collectionView.collectionViewLayout = layout
    collectionView.isSelectable = true
    collectionView.allowsMultipleSelection = false
    collectionView.allowsEmptySelection = false
    
    collectionView.register(CalendarDayItem.self, forItemWithIdentifier: CalendarDayItem.identifier)
    return collectionView
  }()
  
  var dayStackView: NSStackView!
  
  private let dayLabels: [NSTextField] = {
    let dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    let availableWidth = 316 - 40
    let itemWidth = availableWidth / 7
    
    return dayNames.map { day in
      let label = NSTextField(labelWithString: day)
      label.alignment = .center
      label.font = .systemFont(ofSize: 12)
      
      label.snp.makeConstraints { make in
        make.width.equalTo(itemWidth)
      }
      
      return label
    }
  }()
  
  private var streakDates: Set<Date> = []
  private let calendar = Calendar(identifier: .gregorian)
  private var currentDate = Date()
  private let stackView = NSStackView()
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  private func setupView() {
    wantsLayer = true
    orientation = .vertical
    alignment = .centerX
    distribution = .fill
    spacing = 8
    
    setupHeader()
    setupDayLabels()
    setupCollectionView()
    setupStreakDates()
    generateDays(for: currentMonth)
  }
  
  private func setupHeader() {
    addArrangedSubview(calendarHeaderView)
    setCustomSpacing(16, after: calendarHeaderView)
    
    calendarHeaderView.onPreviousMonth = { [weak self] month in
      
      guard let self else { return }
      
      self.currentMonth = month
      self.generateDays(for: month)
    }
    
    calendarHeaderView.onNextMonth = { [weak self] month in
      
      guard let self else { return }
      
      self.currentMonth = month
      self.generateDays(for: month)
    }
  }
  
  private func setupDayLabels() {
    dayStackView = NSStackView(views: dayLabels)
    dayStackView.orientation = .horizontal
    
    addArrangedSubview(dayStackView)
  }
  
  private func setupCollectionView() {
    addArrangedSubview(collectionView)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
  }
  
  private func setupStreakDates() {
    for dayOffset in -4...0 {
      if let date = calendar.date(byAdding: .day, value: dayOffset, to: Date()) {
        streakDates.insert(date)
      }
    }
  }
  
  func generateDays(for date: Date) {
    days = []
    
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.month, .year], from: date)
    guard let firstDayOfMonth = calendar.date(from: components) else { return }
    
    // Get number of days in the month
    let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!
    let numDaysInMonth = range.count
    
    // Find out which weekday the month starts on
    let weekdayOfFirst = calendar.component(.weekday, from: firstDayOfMonth) - 1
    
    // Add padding for the first week if the month doesn't start on Sunday (or preferred weekday)
    for _ in 0..<weekdayOfFirst {
      days.append(CalendarDay(date: nil, dayNumber: nil, isCurrentMonth: false))
    }
    
    // Add days of the month
    for day in 1...numDaysInMonth {
      let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth)
      days.append(CalendarDay(date: date, dayNumber: day, isCurrentMonth: true))
    }
  }
  
  func isDateSame(date1: Date, date2: Date) -> Bool {
    
//    let day = calendar.compare(date1, to: date2, toGranularity: .day)
//    let month = calendar.compare(date1, to: date2, toGranularity: .month)
//    let year = calendar.compare(date1, to: date2, toGranularity: .year)
    
    return calendar.isDate(date1, inSameDayAs: date2)
  }
}

extension CalendarView: NSCollectionViewDataSource, NSCollectionViewDelegate {
  
  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    days.count
  }
  
  func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    guard let item = collectionView.makeItem(withIdentifier: CalendarDayItem.identifier, for: indexPath) as? CalendarDayItem else {
      return NSCollectionViewItem()
    }
    
    let day = days[indexPath.item]
    
    guard let date = day.date, let dayNumber = day.dayNumber else { return NSCollectionViewItem() }
    
    let isStreak = streakDays.contains { isDateSame(date1: $0.date, date2: date ) }
    
    var isFirst = false
    var isLast = false
    if streakDays.count == 1 {
      isFirst = true
      isLast = true
    } else {
      let index = streakDays.firstIndex(where: { isDateSame(date1: $0.date, date2: date) })
      
      if let index {
        if index == 0 {
          isFirst = true
          isLast = false
        }
        
        if index == streakDays.count - 1 {
          isFirst = false
          isLast = true
        }
      }
    }
    
    if day.isCurrentMonth {
      item.configure(
        with: dayNumber,
        isStreak: isStreak,
        isFirst: isFirst,
        isLast: isLast,
        radius: CGFloat(availableWidth / 6 / 2)
      )
    } else {
      item.configure(with: nil)
    }
    
    return item
  }
}


#Preview(traits: .fixedLayout(width: 356, height: 600), body: {
  CalendarView()
})
