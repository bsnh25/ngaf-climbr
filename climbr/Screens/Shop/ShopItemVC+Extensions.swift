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
        guard var character else { return }
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
        
        self.getCharacterData()
        
        self.delegate?.characterDidUpdate()
    }
    
    func updateCharacterEquipment() {
        guard let character else { return }
        
        animationShop?.setInput("Headgear", value: Double(character.headEquipment.itemID))
        
        animationShop?.setInput("Stick", value: Double(character.handEquipment.itemID))
        animationShop?.setInput("Jacket", value: Double(character.handEquipment.itemID))
        animationShop?.setInput("RightThigh", value: Double(character.handEquipment.itemID))
        animationShop?.setInput("LeftThigh", value: Double(character.handEquipment.itemID))
        animationShop?.setInput("RightShin", value: Double(character.handEquipment.itemID))
        animationShop?.setInput("LeftShin", value: Double(character.handEquipment.itemID))
        
        animationShop?.setInput("Backpack", value: Double(character.backEquipment.itemID))
        animationShop?.setInput("Tent", value: Double(character.backEquipment.itemID))
        
        animationShop?.setInput("Background", value: Double(character.locationEquipment.itemID))
        
    }
}

extension ShopItemVC : CollectionContainerProtocol {
    
    func itemSelectedChangedWithType(to equipment: EquipmentModel) {
        self.selectedItem = equipment
        collectionViewContainer.hView.configure(equipmentModel: equipment)
        switch equipment.type{
            
        case .head:
            animationShop?.setInput("Headgear", value: Double(equipment.item.itemID))
        case .hand:
            animationShop?.setInput("Stick", value: Double(equipment.item.itemID))
            animationShop?.setInput("Jacket", value: Double(equipment.item.itemID))
            animationShop?.setInput("RightThigh", value: Double(equipment.item.itemID))
            animationShop?.setInput("LeftThigh", value: Double(equipment.item.itemID))
            animationShop?.setInput("RightShin", value: Double(equipment.item.itemID))
            animationShop?.setInput("LeftShin", value: Double(equipment.item.itemID))
        case .back:
            animationShop?.setInput("Backpack", value: Double(equipment.item.itemID))
            animationShop?.setInput("Tent", value: Double(equipment.item.itemID))
        case .location:
            animationShop?.setInput("Background", value: Double(equipment.item.itemID))
        }
        
        
        if let character {
            print("price: ", Int(character.point) < equipment.item.price)
            buyButton.itemButton.isEnabled = !(Int(character.point) < equipment.item.price)
        }
        
        if equipment.isUnlocked, let selectedItem = self.selectedItem {
            self.updateCharacter(with: selectedItem)
            
        }
        collectionViewContainer.hView.configure(text: "", backgroundImage: NSImage(named: equipment.item.image))
        
        buyButton.updateItemButtonPreview(
            item: equipment.item,
            price: equipment.item.price,
            point: Int(character?.point ?? 0)
        )
        priceLabel.setText("􀀈\(equipment.item.price)")
        print("Ini \(equipment.item.price)")
        buyButton.itemButton.isEnabled = !equipment.isUnlocked
    }
}

extension ShopItemVC: BuyButtonDelegate {
    func didPurchased() {
        guard let character, let selectedItem else { return }
        
        print("halo")
        if character.point >= selectedItem.item.price {
            print("Char Point 1: \(character.point)")
            print("Item Price: \(selectedItem.item.price)")
            equipmentService?.purchaseEquipment(data: selectedItem.item)
            print("Char Point 2: \(character.point)")
            let point = selectedItem.item.price
            print("Char Point 3: \(character.point)")
            characterService.updatePoint(character: character, points: -point)
            self.character = characterService.getCharacterData()
            print("Char Point 4: \(character.point)")
            updateData(with: selectedItem.type)
            print("Char Point 5: \(character.point)")
            self.updateCharacter(with: selectedItem)
            print("Char Point 6: \(character.point)")
            buyButton.isHidden = false
            buyButton.itemButton.isEnabled = false
        }else{
            print("kurang point")
        }
        
    }
}
