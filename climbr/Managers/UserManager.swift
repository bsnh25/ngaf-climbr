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
    
    func getCharacterData() -> Character? {
        guard let container = container else {return nil}
        let request: NSFetchRequest<Character> = Character.fetchRequest()
        
        
        do {
            return try container.fetch(request).first
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveCharacterData(data: UserModel) {
        guard let container = container else { return }
        
        let newUserData = Character(context: container)
        
        newUserData.id = data.id
        newUserData.name = data.name
        newUserData.point = data.point
        
        do {
            try container.save()
            print("saved")
        } catch {
            print("Failed to save context: \(error)")
        }
        
    }
    
    func updatePoint(character: Character, points: Int) {
        
    }
    
    //MARK: TODO
}
