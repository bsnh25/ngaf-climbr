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
    
    func getPreferences() -> UserPreferences? {
        guard let container = container else {return nil}
        
        let request: NSFetchRequest<UserPreferences> = UserPreferences.fetchRequest()
        
        do {
            return try container.fetch(request).first
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
            return nil
        }
    }
    
    func savePreferences(data: UserPreferenceModel) {
        guard let container = container else {return }
        
        let newUserPreference = UserPreferences(context: container)
        
        newUserPreference.id = data.id
        newUserPreference.endWorkingHour = data.endWorkingHour
        newUserPreference.launchAtLogin = data.launchAtLogin
        newUserPreference.reminderInterval = data.reminderInterval
        newUserPreference.startWorkingHour = data.startWorkingHour
        newUserPreference.endWorkingHour = data.endWorkingHour
        
        
        do {
            try container.save()
            print("saved")
        } catch {
            print("Failed to save context: \(error)")
        }
        
    }
    
    func updatePreferences(data: UserPreferenceModel) {
        guard let container = container else { return }
        
        let request: NSFetchRequest<UserPreferences> = UserPreferences.fetchRequest()
        request.fetchLimit = 1
        
        do {
            if let fetchResult = try container.fetch(request).first {
                fetchResult.startWorkingHour = data.startWorkingHour
                fetchResult.endWorkingHour = data.endWorkingHour
                fetchResult.reminderInterval = data.reminderInterval
                fetchResult.launchAtLogin = data.launchAtLogin
                
                // Save the context after updating
                try container.save()
                print("Preferences updated successfully.")
            } else {
                print("No preferences found to update.")
            }
        } catch {
            print("Error fetching or updating user preferences: \(error.localizedDescription)")
        }
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
