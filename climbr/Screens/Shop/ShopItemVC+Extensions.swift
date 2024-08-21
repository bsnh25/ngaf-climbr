//
//  ShopItemVC+Extensions.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 20/08/24.
//

import Foundation
import Cocoa

extension ShopItemVC {
    func updateCharacter(with data: EquipmentModel) {
        guard let characterService, var character else { return }
        print("update character")
        
        switch(data.type) {
        case .head:
            character.headEquipment = data.item
        case .hand:
            character.handEquipment = data.item
        case .back:
            character.backEquipment = data.item
        case .location:
            character.locationEquipment = data.item
        }
        
        characterService.updateCharacter(with: character)
        
        
        getCharacterData()
    }
}

extension ShopItemVC : CollectionContainerProtocol {
//    func updateCurrentItem(head: EquipmentItem, hand: EquipmentItem, back: EquipmentItem, location: EquipmentItem, isUnlocked: Bool, type: EquipmentType) {
//        self.collectionViewContainer.collectionView.reloadData()
        
//        currentHead = head
//        currentHeadModel.item = head
//        currentHand = hand
//        currentHandModel.item = hand
//        currentBack = back
//        currentBackModel.item = back
//        currentLocation = location
//        currentLocationModel.item = location
//        
//        switch type {
//        case .head:
//            currentHeadModel.isUnlocked = isUnlocked
//            buyButton.updateItemButtonPreview(item: head, price: head.price, point: Int((characterService?.getCharacterData()!.point)!))
//            
//            print("di dalem head \(head.name)")
//            if selectedItem != head {
//                let temporaryItem = selectedItem
//                selectedItem = head
//                buyButton.isHidden = isUnlocked
//                if temporaryItem != selectedItem{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                        self.collectionViewContainer.collectionView.reloadData()
//                    }
//                }
//            }
//        case .hand:
//            currentHandModel.isUnlocked = isUnlocked
//            buyButton.updateItemButtonPreview(item: hand, price: hand.price, point: Int((characterService?.getCharacterData()!.point)!))
//            
//            
//            print("di dalem hand \(hand.name)")
//            if selectedItem != hand {
//                let temporaryItem = selectedItem
//                selectedItem = hand
//                buyButton.isHidden = isUnlocked
//                if temporaryItem != selectedItem{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                        self.collectionViewContainer.collectionView.reloadData()
//                    }
//                }
//            }
//        case .back:
//            currentBackModel.isUnlocked = isUnlocked
//            buyButton.updateItemButtonPreview(item: back, price: back.price, point: Int((characterService?.getCharacterData()!.point)!))
//            print("di dalem back \(back.name)")
//            if selectedItem != back {
//                let temporaryItem = selectedItem
//                selectedItem = back
//                buyButton.isHidden = isUnlocked
//                if temporaryItem != selectedItem{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                        self.collectionViewContainer.collectionView.reloadData()
//                    }
//                }
//            }
//        case .location:
//            currentLocationModel.isUnlocked = isUnlocked
//            buyButton.updateItemButtonPreview(item: location, price: location.price, point: Int((characterService?.getCharacterData()!.point)!))
//            print("di dalem loc \(location.name)")
//            if selectedItem != location {
//                let temporaryItem = selectedItem
//                selectedItem = location
//                buyButton.isHidden = isUnlocked
//                if temporaryItem != selectedItem{
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                        self.collectionViewContainer.collectionView.reloadData()
//                    }
//                }
//            }
//        }
//        self.collectionViewContainer.collectionView.reloadData()
//    }
    
    func itemSelectedChangedWithType(to equipment: EquipmentModel) {
        self.selectedItem = equipment
        
        
        if let character {
            print("price: ", Int(character.point) < equipment.item.price)
            buyButton.itemButton.isEnabled = !(Int(character.point) < equipment.item.price)
        }
        
        if equipment.isUnlocked, let selectedItem = self.selectedItem {
            self.updateCharacter(with: selectedItem)
        }
        
//        switch type {
//        case .head:
////            currentHead = item
////            currentHeadModel.item = item
////            currentHeadModel.isUnlocked = isUnlocked
//        case .hand:
////            currentHand = item
////            currentHandModel.item = item
////            currentHandModel.isUnlocked = isUnlocked
//        case .back:
////            currentBack = item
////            currentBackModel.item = item
////            currentBackModel.isUnlocked = isUnlocked
//        case .location:
////            currentLocation = item
////            currentLocationModel.item = item
////            currentLocationModel.isUnlocked = isUnlocked
//        }
        
//        print("head : \(currentHead), hand: \(currentHand), back: \(currentBack), location: \(currentLocation)")
        
//        collectionViewContainer.updateCurrentItem(head: currentHead, hand: currentHand, back: currentBack, location: currentLocation)
//        points.setText("\(item.price)")
        buyButton.updateItemButtonPreview(item: equipment.item, price: equipment.item.price, point: Int(character?.point ?? 0))
        buyButton.isHidden = equipment.isUnlocked
//        print(selectedGridItem?.item?.name)
//        collectionViewContainer.collectionView.reloadData()
    }
}

//extension ShopItemVC: gridItemSelectionProtocol {
//    func gridItemSelectionDidChange(to newSelected: EquipmentItem, type: EquipmentType, isUnlocked: Bool) {
//        selectedItem = newSelected
//        buyButton.updateItemButtonPreview(item: newSelected, price: newSelected.price, point: Int((characterService?.getCharacterData()!.point)!))
//        buyButton.isHidden = isUnlocked
//        print("buyButton")
//    }
//    
//    func gridItemSelectionDidChange(to newSelected: GridItem) {
//        print("dalam sini")
//        self.selectedGridItem = newSelected
//        collectionViewContainer.updateCurrentGridItem(gridItem: newSelected)
//        points.setText("\(String(describing: newSelected.item?.price))")
//        buyButton.updateItemButtonPreview(item: newSelected.item!, price: newSelected.item!.price, point: Int((characterService?.getCharacterData()!.point)!))
//        buyButton.isHidden = newSelected.isUnlocked
//    }
//}

//extension ShopItemVC: collectionItemProtocol{
//    func collectionItemDidChange(to newSelected: EquipmentItem, type: EquipmentType, isUnlocked: Bool) {
//        selectedItem = newSelected
//        
//        switch type {
//        case .head:
//            currentHead = newSelected
//            currentHeadModel.item = newSelected
//            currentHeadModel.isUnlocked = isUnlocked
//        case .hand:
//            currentHand = newSelected
//            currentHandModel.item = newSelected
//            currentHandModel.isUnlocked = isUnlocked
//        case .back:
//            currentBack = newSelected
//            currentBackModel.item = newSelected
//            currentBackModel.isUnlocked = isUnlocked
//        case .location:
//            currentLocation = newSelected
//            currentLocationModel.item = newSelected
//            currentLocationModel.isUnlocked = isUnlocked
//        }
//        
//        collectionViewContainer.collectionView.reloadData()
//        
//        print("head : \(currentHead), hand: \(currentHand), back: \(currentBack), location: \(currentLocation)")
//        
//        print(newSelected.name)
//        buyButton.updateItemButtonPreview(item: newSelected, price: newSelected.price, point: Int((characterService?.getCharacterData()!.point)!))
//        buyButton.isHidden = isUnlocked
//        print("dalam collectionItemDidChange di VC -> \(newSelected.name)")
//    }
//}

extension ShopItemVC: BuyButtonDelegate {
    func didPurchased() {
        guard let character, let selectedItem else { return }
        
        print("halo")
        if character.point >= selectedItem.item.price {
            equipmentService?.purchaseEquipment(data: selectedItem.item)
            
            //            character?.getCharacterData()!.point = Int64(currentPoint! - itemPrice!)
//            if let charMod = character?.getCharacterData(){
//                let point = currentPoint! - itemPrice!
//                character?.updatePoint(character: charMod, points: point)
//            }
            let point = Int(character.point) - selectedItem.item.price
            characterService?.updatePoint(character: character, points: point)
//            delegate?.didPurchaseItem()
            
            updateData(with: selectedItem.type)
            
            self.updateCharacter(with: selectedItem)
            buyButton.isHidden = true
        }else{
            print("kurang point")
        }
        
        
        
        
        
        
        
        
//        if let heads = equipmentService?.getEquipments(equipmentType: .head) {
////            headItems = heads
//        }
//        if let backs = equipmentService?.getEquipments(equipmentType: .back) {
////            backItems = backs
//        }
//        if let hands = equipmentService?.getEquipments(equipmentType: .hand) {
////            handItems = hands
//        }
//        if let locations = equipmentService?.getEquipments(equipmentType: .location) {
////            locationItems = locations
//        }
//        
////        collectionViewContainer.updateItems
//        switch itemType {
//        case .head:
////            collectionViewContainer.updateItems(items: headItems)
//            
//            buyButton.updateItemButtonPreview(item: currentHead, price: currentHead.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = true
//        case .hand:
////            collectionViewContainer.updateItems(items: handItems)
//            
//            buyButton.updateItemButtonPreview(item: currentHand, price: currentHand.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = true
//        case .back:
////            collectionViewContainer.updateItems(items: backItems)
//            
//            buyButton.updateItemButtonPreview(item: currentBack, price: currentBack.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = true
//        case .location:
////            collectionViewContainer.updateItems(items: locationItems)
//            
//            buyButton.updateItemButtonPreview(item: currentLocation, price: currentLocation.price, point: Int((characterService?.getCharacterData()!.point)!))
//            buyButton.isHidden = true
//        }
//        
////        collectionViewContainer.updateCurrentItem(head: currentHead, hand: currentHand, back: currentBack, location: currentLocation)
//        
//        collectionViewContainer.collectionView.reloadData()
//        points.setText(String((characterService?.getCharacterData()!.point)!))
    }
}
