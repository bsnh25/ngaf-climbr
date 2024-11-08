//
//  CLPickerButton.swift
//  climbr
//
//  Created by Bayu Septyan Nur Hidayat on 14/08/24.
//

import Cocoa

class CLPickerButton: NSButton {
    
    var isSelected: Bool = true {
            didSet {
                updateLayer()
            }
        }
  
  override var isEnabled: Bool {
    didSet {
       if !isEnabled {
           layer?.backgroundColor = layer?.backgroundColor?.copy(alpha: 0.2)
       }
    }
  }

  
    var backgroundColor: NSColor!
    var foregroundColorText: NSColor! {
            didSet {
                updateAttributedTitle()
            }
        }
    var fontText: NSFont! {
            didSet {
                updateAttributedTitle()
            }
        }
  
  var subtitle: String?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.isBordered = false // Remove default button border
        self.wantsLayer = true // Ensure the layer is available for custom drawing
    }
  init(title: String, subtitle: String? = nil, backgroundColor: NSColor, foregroundColorText: NSColor, fontText: NSFont, isSelected: Bool = false) {
        super.init(frame: .zero)
        
        wantsLayer = true
        
        self.title                  = title
    self.subtitle = subtitle
        self.isBordered             = false
        layer?.backgroundColor      = backgroundColor.cgColor
        
        self.backgroundColor        = backgroundColor
        self.foregroundColorText    = foregroundColorText
        self.fontText               = fontText
    self.isSelected = isSelected
       
        configure(foregroundColorText: foregroundColorText, font: fontText)
    }
    
    init(title: String, borderColor: NSColor, font: NSFont) {
        super.init(frame: .zero)
        
        self.wantsLayer             = true
        self.title                  = title
        self.isBordered             = false
        self.layer?.borderColor     = borderColor.cgColor
        self.layer?.borderWidth     = 1.5
        
        configure(foregroundColorText: borderColor, font: font)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure(foregroundColorText: NSColor, font: NSFont) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: foregroundColorText,
            .font: font
        ]
        
        attributedTitle     = NSAttributedString(string: self.title, attributes: attributes)
        layer?.cornerRadius = 10
        bezelStyle          = .flexiblePush
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func updateAttributedTitle() {
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: foregroundColorText ?? NSColor.black, // Use your default color if needed
                .font: fontText ?? NSFont.systemFont(ofSize: 14) // Use your default font if needed
            ]
            
            attributedTitle = NSAttributedString(string: self.title, attributes: attributes)
        }

    override func updateLayer() {
       super.updateLayer()
      
      if isSelected {
        layer?.backgroundColor = NSColor.cNewButton.cgColor
        foregroundColorText = .white
      } else {
        layer?.backgroundColor = backgroundColor.cgColor
        foregroundColorText = .black
      }
      
      updateAttributedTitle()
        
   }
    
}
