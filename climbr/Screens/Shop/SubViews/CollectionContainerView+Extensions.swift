//
//  CollectionContainerView+Extensions.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 20/08/24.
//

import Foundation
import Cocoa

//extension CollectionContainerView: gridItemSelectionProtocol {
//    func gridItemSelectionDidChange(to newSelected: EquipmentItem, type: EquipmentType, isUnlocked: Bool) {
//        switch type {
//        case .head:
//            currentHead = newSelected
//        case .hand:
//            currentHand = newSelected
//        case .back:
//            currentBack = newSelected
//        case .location:
//            currentLocation = newSelected
//        }
////        print("di dalam collection view head: \(currentHead), hand: \(currentHand), back: \(currentBack), location: \(currentLocation)")
//        
//        collectionDelegate?.updateCurrentItem(head: currentHead!, hand: currentHand!, back: currentBack!, location: currentLocation!, isUnlocked: isUnlocked, type: type)
////        collectionDelegate?.itemSelectedChangedWithType(to: newSelected, type: type, isUnlocked: isUnlocked)
////        currentGridItem = newSelected
////        collectionDelegate?.itemSelectedChangedWithType(to: newSelected.item!, type: newSelected.type!)
//    }
//    
//    func gridItemSelectionDidChange(to newSelected: GridItem) {
//        switch newSelected.type {
//        case .head:
//            currentHead = newSelected.item
//        case .hand:
//            currentHand = newSelected.item
//        case .back:
//            currentBack = newSelected.item
//        case .location:
//            currentLocation = newSelected.item
//        case .none:
//            break
//        }
//        currentGridItem = newSelected
//    }
//}


extension CollectionContainerView {
    func selectCurrentItem(with data: EquipmentItem) {
        /// Get selected item index
        if let index = equipmentCollections.firstIndex(where: { $0.item == data }) {
            /// Always use section 0 because the collection view only has 1 section (current case)
            let indexPaths: Set<IndexPath> = [IndexPath(item: index, section: 0)]
            
            collectionView.selectItems(at: indexPaths, scrollPosition: .centeredHorizontally)
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
            collectionDelegate?.itemSelectedChangedWithType(to: data)
        }
    }
}

//cek di sini!!!!
//extension CollectionContainerView: collectionItemProtocol {
//    func collectionItemDidChange(to newSelected: EquipmentItem, type: EquipmentType, isUnlocked: Bool) {
//        switch type {
//        case .head:
//            currentHead = newSelected
//        case .hand:
//            currentHand = newSelected
//        case .back:
//            currentBack = newSelected
//        case .location:
//            currentLocation = newSelected
//        }
//        
////        print("di dalam collection view head: \(currentHead), hand: \(currentHand), back: \(currentBack), location: \(currentLocation)")
//        
//        collectionDelegate?.updateCurrentItem(head: self.currentHead!, hand: self.currentHand!, back: self.currentBack!, location: self.currentLocation!, isUnlocked: isUnlocked, type: type)
//    }
//}
