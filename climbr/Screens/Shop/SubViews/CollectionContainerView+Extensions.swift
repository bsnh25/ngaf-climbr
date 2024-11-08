//
//  CollectionContainerView+Extensions.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 20/08/24.
//

import Foundation
import Cocoa

extension CollectionContainerView {
    func selectCurrentItem(with data: EquipmentItem) {
        /// Get selected item index
        if let index = equipmentCollections.firstIndex(where: { $0.item == data }) {
            /// Always use section 0 because the collection view only has 1 section (current case)
            let indexPaths: Set<IndexPath> = [IndexPath(item: index, section: 0)]
            hView.configure(equipmentModel: equipmentCollections[index])
            hView.configure(text: "", backgroundImage: NSImage(named: data.image))
            titleItems.setText("\(data.name)")
            collectionView.selectItems(at: indexPaths, scrollPosition: .centeredHorizontally)
            titleItems.setAccessibilityTitle("Current you see \(data.name) Equipment")
        }
    }
}

extension CollectionContainerView: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print("Click")
        guard let indexPath = indexPaths.first,
              let cell = collectionView.item(at: indexPath) as? GridItem else {
            return
        }
        
        print(indexPath)
        
        if let data = cell.data {
            titleItems.setText("\(data.item.name)")
            collectionDelegate?.itemSelectedChangedWithType(to: data)
            hView.configure(text: "", backgroundImage: NSImage(named: data.item.image))
        }
        
    }
    
}
