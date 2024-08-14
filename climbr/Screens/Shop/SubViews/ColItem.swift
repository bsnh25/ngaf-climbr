//
//  ColItem.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 14/08/24.
//

import Cocoa

class CollectionViewItem: NSCollectionViewItem {

    var itemView: ItemView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    override func loadView() {
        self.itemView = ItemView(frame: NSZeroRect)
        self.view = self.itemView!
    }

    func getView() -> ItemView {
        return self.itemView!
    }
}
