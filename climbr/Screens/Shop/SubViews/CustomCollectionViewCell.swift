//
//  CustomCollectionViewCell.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class CustomCollectionViewCell: NSCollectionViewItem {
    static let identifier = "CustomCollectionViewCell"
    
    private let myLabel = CLLabel(fontSize: 16, fontWeight: .bold)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configure(label: String){
        myLabel.setText(label)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.backgroundColor = .red
        myLabel.textColor = .white
        
        view.addSubview(myLabel)
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        view.layer?.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: view.topAnchor),
            myLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            myLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//    }
}

//class CustomCollectionViewCell: NSCollectionViewItem {
//    static let identifier = "CustomCollectionViewCell"
//    var My2ndimageView: NSImageView!
//    var button: NSButton!
//    
//    private let myImageView : NSImageView = {
//        let iv = NSImageView()
//        iv.image = NSImage(named: "questionmark")
//        iv.clipsToBounds = true
//        return iv
//    }()
//    
//    override func viewDidLoad() {
////        super.viewDidLoad()
//        // Do view setup here.
//        view.wantsLayer = true
//                view.layer?.backgroundColor = NSColor.lightGray.cgColor
//                
//                // Create and configure the image view
//        My2ndimageView = NSImageView(frame: NSRect(x: 10, y: 40, width: 80, height: 80))
//        My2ndimageView.imageScaling = .scaleProportionallyUpOrDown
//        My2ndimageView.image = NSImage(named: NSImage.Name("example"))  // Replace with your image name
//        view.addSubview(My2ndimageView)
//                
//        // Create and configure the button
//        button = NSButton(frame: NSRect(x: 10, y: 10, width: 80, height: 30))
//        button.title = "Click Me"
//        button.target = self
//        button.action = #selector(buttonClicked)
//        view.addSubview(button)
//                
//                // Customize the text field
//        textField?.font = NSFont.systemFont(ofSize: 14)
//        textField?.textColor = NSColor.black
//        textField?.alignment = .center
//        textField?.frame = NSRect(x: 100, y: 10, width: 100, height: 30)  // Adjust frame as needed
//            }
//    
//    @objc func buttonClicked() {
//        print("Button was clicked!")
//    }
//    
//    func configure(with image: NSImage){
//        self.myImageView.image = image
//        self.setupUI()
//    }
//    
//    func setupUI(){
//        
//    }
//}
