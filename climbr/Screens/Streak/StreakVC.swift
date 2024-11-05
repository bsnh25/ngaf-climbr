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
    
    let headerView: HeaderStreakView = HeaderStreakView()
    let calendarView: CalendarView = CalendarView()
    let outterVStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.edgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
        stack.spacing = 26
        stack.alignment = .centerX
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        // Tambahkan `headerView` dan `calendarView` ke dalam `outterVStack`
        outterVStack.addArrangedSubview(headerView)
        outterVStack.addArrangedSubview(calendarView)
        
        // Tambahkan `outterVStack` ke tampilan utama
        view.addSubview(outterVStack)
        
        outterVStack.wantsLayer = true
        outterVStack.layer?.borderColor = .black
        outterVStack.layer?.borderWidth = 1
        
        headerView.wantsLayer = true
        headerView.layer?.borderColor = NSColor.red.cgColor
        headerView.layer?.borderWidth = 1
        
        // Tambahkan constraints untuk `outterVStack`
        outterVStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            outterVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            outterVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            outterVStack.topAnchor.constraint(equalTo: view.topAnchor),
//            outterVStack.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            outterVStack.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
    
    func updateStreak(){
        headerView.updateValue(value: "Hayo")
    }
    
}
