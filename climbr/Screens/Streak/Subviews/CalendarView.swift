//
//  CalendarView.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 05/11/24.
//
import Cocoa
import AppKit
import SnapKit

class CalendarView: NSView {
    
    private let datePicker: NSDatePicker = {
        let picker = NSDatePicker()
        picker.datePickerMode = .single
        picker.datePickerStyle = .textFieldAndStepper
        picker.isBezeled = true
        picker.isBordered = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let collectionView: NSCollectionView = {
        let collectionView = NSCollectionView()
        let layout = NSCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.itemSize = NSSize(width: 30, height: 30)
        collectionView.collectionViewLayout = layout
        collectionView.isSelectable = true
        collectionView.allowsMultipleSelection = true
        collectionView.register(CalendarDayItem.self, forItemWithIdentifier: CalendarDayItem.identifier)
        return collectionView
    }()
    
    private let monthYearLabel: NSTextField = {
        let label = NSTextField(labelWithString: "")
        label.font = .boldSystemFont(ofSize: 16)
        label.alignment = .center
        return label
    }()
    
    private let dayLabels: [NSTextField] = {
        let dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        return dayNames.map { day in
            let label = NSTextField(labelWithString: day)
            label.alignment = .center
            label.font = .systemFont(ofSize: 12)
            return label
        }
    }()
    
    private var streakDates: Set<Date> = []
    private let calendar = Calendar(identifier: .gregorian)
    private var currentDate = Date()
    private let stackView = NSStackView()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
//        setupDatePicker()
//        setupMonthYearLabel()
        stackViewConfig()
        setupDayLabels()
        setupCollectionView()
        setupStreakDates()
    }
    
    private func stackViewConfig() {
        addSubview(stackView)
        stackView.addArrangedSubview(monthYearLabel)
        stackView.addArrangedSubview(datePicker)
        stackView.alignment = .centerX
        stackView.orientation = .horizontal
        stackView.spacing = 10
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.horizontalEdges.equalTo(self.snp.horizontalEdges)
        }
        
        datePicker.dateValue = currentDate
        datePicker.target = self
        datePicker.action = #selector(datePickerChanged(_:))
        datePicker.wantsLayer = true
        datePicker.layer?.borderColor = NSColor.orange.cgColor
        datePicker.layer?.borderWidth = 1
        
        monthYearLabel.wantsLayer = true
        monthYearLabel.layer?.borderColor = NSColor.orange.cgColor
        monthYearLabel.layer?.borderWidth = 1
        
        updateMonthYearLabel()
    }
    
    private func setupDatePicker() {
//        addSubview(datePicker)
        let formateDate = DateFormatter()
        formateDate.dateFormat = "MMMM yyyy"
        let formattedDateString = formateDate.string(from: currentDate)
         
        datePicker.dateValue = currentDate // Set default date
        
        datePicker.wantsLayer = true
        datePicker.layer?.borderColor = NSColor.orange.cgColor
        datePicker.layer?.borderWidth = 1
        
        datePicker.target = self
        datePicker.action = #selector(datePickerChanged(_:))
        
//        NSLayoutConstraint.activate([
//            datePicker.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            datePicker.centerXAnchor.constraint(equalTo: centerXAnchor)
//        ])
    }
    
    private func setupMonthYearLabel() {
//        addSubview(monthYearLabel)
        monthYearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        monthYearLabel.wantsLayer = true
        monthYearLabel.layer?.borderColor = NSColor.orange.cgColor
        monthYearLabel.layer?.borderWidth = 1
        
//        NSLayoutConstraint.activate([
//            monthYearLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
//            monthYearLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
//        ])
        updateMonthYearLabel()
    }
    
    private func setupDayLabels() {
        let dayStackView = NSStackView(views: dayLabels)
        dayStackView.orientation = .horizontal
        dayStackView.distribution = .fillEqually
        addSubview(dayStackView)
        
        dayStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            dayStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: dayLabels.first!.bottomAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupStreakDates() {
        for dayOffset in -4...0 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: Date()) {
                streakDates.insert(date)
            }
        }
    }
    
    private func updateMonthYearLabel() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        monthYearLabel.stringValue = formatter.string(from: currentDate)
    }
    
    @objc private func datePickerChanged(_ sender: NSDatePicker) {
        currentDate = sender.dateValue
        updateMonthYearLabel()
        collectionView.reloadData()
    }
}

extension CalendarView: NSCollectionViewDataSource, NSCollectionViewDelegate {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        let range = calendar.range(of: .day, in: .month, for: currentDate)!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let weekday = calendar.component(.weekday, from: firstDayOfMonth) - 1
        return range.count + weekday
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        guard let item = collectionView.makeItem(withIdentifier: CalendarDayItem.identifier, for: indexPath) as? CalendarDayItem else {
            return NSCollectionViewItem()
        }
        
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
        let weekday = calendar.component(.weekday, from: firstDayOfMonth) - 1
        
        if indexPath.item >= weekday {
            let day = indexPath.item - weekday + 1
            if let date = calendar.date(bySetting: .day, value: day, of: firstDayOfMonth) {
                let isStreak = streakDates.contains(date)
                item.configure(with: day, isStreak: isStreak, hasEvent: false)
            }
        } else {
            item.configure(with: nil, isStreak: false, hasEvent: false)
        }
        
        return item
    }
}
