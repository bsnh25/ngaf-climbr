//
//  StreakVC.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 05/11/24.
//

import Cocoa
import AppKit
import SnapKit

class StreakVC: NSViewController {
  var streakService: StreakService?
  
    private let headerView: HeaderStreakView = HeaderStreakView()
    private let calendarView: CalendarView = CalendarView()
    private let outterVStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.spacing = 24
        return stack
    }()
  
  init(streakService: StreakService? = nil) {
    self.streakService = streakService
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillAppear() {
    super.viewWillAppear()
    
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        setupViews()
        calendarView.streakDays = streakService?.getStreakHistory() ?? []
    }
    
    func setupViews() {
        // Tambahkan `headerView` dan `calendarView` ke dalam `outterVStack`
        outterVStack.addArrangedSubview(headerView)
        outterVStack.addArrangedSubview(calendarView)
        
        // Tambahkan `outterVStack` ke tampilan utama
        view.addSubview(outterVStack)
      
        outterVStack.snp.makeConstraints { make in
          make.edges.equalToSuperview().inset(20)
        }
    }
    
    func updateStreak(){
        headerView.updateValue(value: "Hayo")
    }
    
}

#Preview(traits: .defaultLayout, body: {
  StreakVC()
})
