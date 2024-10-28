//
//  UserManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import CoreData

class UserManager : CharacterService {
    let container : NSManagedObjectContext?
    
    init(controller: PersistenceController?){
        self.container = controller?.container.viewContext
    }
    
    func getPreferences() {
        
    }
    
    func savePreferences(data: UserPreferenceModel) {
        UserDefaults.setValue(data, forKey: UserDefaultsKey.kUserPreference)
    }
    
    func updatePreferences(data: UserPreferenceModel) {
        UserDefaults.setValue(data, forKey: UserDefaultsKey.kUserPreference)
    }

    
    func getCharacterData() -> CharacterModel? {
        guard let container = container else {return nil}
        let request: NSFetchRequest<Character> = Character.fetchRequest()
        
        do {
            guard let charArr = try container.fetch(request).first else {return nil}
            return CharacterModel(
                name: charArr.name!,
                gender: Gender(rawValue: charArr.gender!)!,
                point: charArr.point,
                headEquipment: EquipmentItem(rawValue: charArr.headEquipment!)!,
                handEquipment: EquipmentItem(rawValue: charArr.handEquipment!)!,
                backEquipment: EquipmentItem(rawValue: charArr.backEquipment!)!,
                locationEquipment: EquipmentItem(rawValue: charArr.locationEquipment!)!
            )
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateCharacter(with data: CharacterModel) {
        guard let container = container else { return }
        
        let request: NSFetchRequest<Character> = Character.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "name == %@", data.name)
        request.predicate = predicate
        
        do {
            if let response = try container.fetch(request).first {
                response.headEquipment = data.headEquipment.rawValue
                response.backEquipment = data.backEquipment.rawValue
                response.handEquipment = data.handEquipment.rawValue
                response.locationEquipment = data.locationEquipment.rawValue
                try container.save()
            }
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
        }
    }
    
    func saveCharacterData(data: CharacterModel) {
            guard let container = container else { return }
            
            let newUserData = Character(context: container)
            
            newUserData.id = data.id
            newUserData.name = data.name
            newUserData.point = data.point
            newUserData.gender = data.gender.rawValue
            newUserData.headEquipment = data.headEquipment.rawValue
            newUserData.handEquipment = data.handEquipment.rawValue
            newUserData.backEquipment = data.backEquipment.rawValue
            newUserData.locationEquipment = data.locationEquipment.rawValue
            
            do {
                try container.save()
                print("saved")
            } catch {
                print("Failed to save context: \(error)")
            }
            
        }
    
    
    func updatePoint(character: CharacterModel, points: Int) {
        guard let container = container else {return}
        let request: NSFetchRequest<Character> = Character.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "name == %@", character.name)
        request.predicate = predicate
        
        do {
            if let response = try container.fetch(request).first {
                response.point += Int64(points)
                try container.save()
            }
        } catch {
            print("Err while save")
        }
    }

}
