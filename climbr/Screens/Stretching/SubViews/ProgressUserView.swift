//
//  ProgressUserView.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 30/10/24.
//

import Cocoa
import AppKit
import SnapKit

class ProgressUserView: NSView {
    
    var stackView      = NSStackView()
    var typeLabel      = CLLabel(fontSize: 17, fontWeight: .bold)
    var valueView      = NSView()
    var valueLabel     = CLLabel(fontSize: 40, fontWeight: .bold)
    
    init(valueProgress: String, typeStretch: String) {
        super.init(frame: .zero)
        configureStack(valueProgress: valueProgress, typeStretch: typeStretch)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStack(valueProgress: String, typeStretch: String) {
        self.addSubview(stackView)
        stackView.wantsLayer = true
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(valueView)
        stackView.orientation = .vertical
        stackView.distribution = .equalSpacing
//        stackView.layer?.backgroundColor = colorBg.cgColor
        stackView.layer?.cornerRadius = 8
        
        typeLabel.stringValue = typeStretch
        valueLabel.stringValue = valueProgress
//        valueLabel.textColor = colorBg
        typeLabel.textColor = .white
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(163)
            make.height.equalTo(131)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
        }
        
        
        configureValueView()
    }
    
    private func configureValueView() {
        valueView.addSubview(valueLabel)
        valueView.wantsLayer = true
        valueView.layer?.backgroundColor = .white
        valueView.layer?.cornerRadius = 8
        
        valueView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.width.equalTo(147)
            make.height.equalTo(85)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    func updateColor(_ color: NSColor) {
        stackView.layer?.backgroundColor = color.cgColor
        valueLabel.textColor = color
    }
    
}
