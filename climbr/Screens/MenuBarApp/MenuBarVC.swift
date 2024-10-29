//
//  MenuBarVC.swift
//  climbr
//
//  Created by Ivan Nur Ilham Syah on 28/10/24.
//

import AppKit
import Swinject

class MenuBarVC: NSViewController {
  private lazy var titleStateLabel: CLLabel = {
    let label = CLLabel()
    label.stringValue = "Status"
    label.textColor = .labelColor
    
    return label
  }()
  
  private lazy var stateLabel: CLLabel = {
    let label = CLLabel()
    label.stringValue = "Capek!!!"
    label.textColor = .cButton
    label.font = .boldSystemFont(ofSize: 22)
    
    return label
  }()
  
  private lazy var stateStackView: NSStackView = {
    let stack = NSStackView(views: [titleStateLabel, stateLabel])
    stack.spacing = 4
    stack.orientation = .vertical
    stack.alignment = .leading
    
    return stack
  }()
  
  private lazy var titleSessionLabel: CLLabel = {
    let label = CLLabel()
    label.stringValue = "Next Session"
    label.textColor = .labelColor
    
    return label
  }()
  
  private lazy var sessionLabel: CLLabel = {
    let label = CLLabel()
    label.stringValue = "13.00"
    label.textColor = .cButton
    label.font = .boldSystemFont(ofSize: 22)
    
    return label
  }()
  
  private lazy var sessionStackView: NSStackView = {
    let stack = NSStackView(views: [titleSessionLabel, sessionLabel])
    stack.spacing = 4
    stack.orientation = .vertical
    stack.alignment = .leading
    
    return stack
  }()
  
  private lazy var stretchNowBtn: CLTextButtonV2 = {
    let button = CLTextButtonV2(title: "Stretch Now", backgroundColor: .cButton, foregroundColorText: .white, fontText: .preferredFont(forTextStyle: .body))
    button.target = self
    button.action = #selector(openStretchNow)
    
    return button
  }()
  
  private lazy var quitBtn: CLTextButtonV2 = {
    let button = CLTextButtonV2(title: "Quit", borderColor: .tertiaryLabelColor, font: .preferredFont(forTextStyle: .body))
    button.target = self
    button.action = #selector(quitApp)
    
    return button
  }()
  
  private lazy var buttonStackView: NSStackView = {
    let stack = NSStackView(views: [stretchNowBtn, quitBtn])
    stack.spacing = 16
    stack.distribution = .fillEqually
    
    return stack
  }()
  
  private lazy var imageView: NSImageView = {
    let imageView = NSImageView()
    imageView.wantsLayer = true
    imageView.layer?.backgroundColor = NSColor.blue.cgColor
    imageView.layer?.cornerRadius = 8
    
    return imageView
  }()
  
  var openStretchNowHandler: (() -> Void)
  var quitAppHandler: (() -> Void)
  
  init(
    onOpenStretchNow: @escaping (() -> Void),
    onQuitApp: @escaping (() -> Void)
  ) {
    
    openStretchNowHandler = onOpenStretchNow
    quitAppHandler = onQuitApp
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViews()
    configureConstraints()
    
  }
  
  private func configureViews() {
    view.addSubview(stateStackView)
    view.addSubview(sessionStackView)
    view.addSubview(buttonStackView)
    view.addSubview(imageView)
    
    view.wantsLayer = true
    view.layer?.backgroundColor = .white
  }
  
  private func configureConstraints() {
    stateStackView.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().inset(16)
    }
    
    sessionStackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(16)
      make.top.equalTo(stateStackView.snp.bottom).offset(16)
    }
    
    stretchNowBtn.snp.makeConstraints { make in
      make.height.equalTo(40)
    }
    
    quitBtn.snp.makeConstraints { make in
      make.height.equalTo(40)
    }
    
    buttonStackView.snp.makeConstraints { make in
      make.leading.bottom.trailing.equalToSuperview().inset(16)
    }
    
    imageView.snp.makeConstraints { make in
      make.width.height.equalTo(116)
      make.trailing.top.equalToSuperview().inset(16)
    }
    
  }
  
  @objc private func openStretchNow(_ sender: Any?) {
    openStretchNowHandler()
  }
  
  @objc private func quitApp(_ sender: Any?) {
    quitAppHandler()
  }
  
}
