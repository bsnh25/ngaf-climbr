//
//  UserManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import CoreData

class UserManager : UserService {
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
    
    func getUserData() -> User? {
        guard let container = container else {return nil}
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        
        do {
            return try container.fetch(request).first
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveUserData(data: UserModel) {
        guard let container = container else { return }
        
        let newUserData = User(context: container)
        
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
    
    func updatePoint(user: User, points: Int) {
        
    }
    
    //MARK: TODO
}
