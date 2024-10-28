//
//  OverlayView.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 28/10/24.
//

import Foundation
import Cocoa
import AppKit
import RiveRuntime

class OverlayView: NSViewController {
    let climbrVm = RiveViewModel(fileName: "overlay_notification-2", artboardName: "sad")
    let btn = NSButton()
    var delegate: OverlayServices?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let riveView = climbrVm.createRiveView()
        riveView.frame = view.bounds
        view.addSubview(riveView)
        
        btn.title = "Dismiss Aku"
        btn.target = self
        btn.action = #selector(self.dismissVC)
        riveView.addSubview(btn)
        
        riveView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        btn.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    @objc private func dismissVC() {
        delegate?.didOverlayDismissed()
    }
    
}
