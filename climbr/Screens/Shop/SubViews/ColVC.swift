//
//  ColVC.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class ColVC: NSViewController {

    var titles = [String]()
    var collectionView: NSCollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.titles = ["Banana", "Apple", "Strawberry", "Cherry", "Pear", "Pineapple", "Grape", "Melon"]
        collectionView = NSCollectionView(frame: self.view.frame)
        collectionView!.itemPrototype = CollectionViewItem()
        collectionView!.content = self.titles
//        collectionView!.autoresizingMask = NSAutoresizingMaskOptions.ViewWidthSizable | NSAutoresizingMaskOptions.ViewMaxXMargin | NSAutoresizingMaskOptions.ViewMinYMargin | NSAutoresizingMaskOptions.ViewHeightSizable | NSAutoresizingMaskOptions.ViewMaxYMargin
//    
        var index = 0
        for title in titles {
            var item = self.collectionView!.item(at: index) as! CollectionViewItem
            item.getView().button?.title = self.titles[index]
            index+=1
        }
        self.view.addSubview(collectionView!)
    }
}
