//
//  UserManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import CoreData

class UserManager : UserService {
    let container = NSPersistentContainer(name: "ClimbrDataSource")
    
    
    init(){
        container.loadPersistentStores{description, error in
            if let error = error{
                print("Core data failed to load: \(error.localizedDescription)")
            }
            
        }
    }
    
    func getPreferences() -> UserPreferences? {
        var request: NSFetchRequest<UserPreferences> = UserPreferences.fetchRequest()
        
        
        do {
            return try container.viewContext.fetch(request).first
        } catch {
            print("Error fetching user preference entries: \(error.localizedDescription)")
            return nil
        }
    }
    
    func savePreferences(data: UserPreferenceModel) {
        print("gans")
        let moc = container.viewContext
        
        let newUserPreference = UserPreferences(context: moc)
        
        newUserPreference.id = data.id
        newUserPreference.endWorkingHour = data.endWorkingHour
        newUserPreference.launchAtLogin = data.launchAtLogin
        newUserPreference.reminderInterval = data.reminderInterval
        newUserPreference.startWorkingHour = data.startWorkingHour
        
        
        do {
            try moc.save()
            print("saved")
        } catch {
            print("Failed to save context: \(error)")
        }
        
    }
    
    func getUserData() -> User? {
#warning("change the return data later")
        return User()
    }
    
    func saveUserData(data: UserModel) {
        let moc = container.viewContext
        
        let newUserData = User(context: moc)
        
        newUserData.id = data.id
        newUserData.name = data.name
        newUserData.point = data.point
        
        
        do {
            try moc.save()
            print("saved")
        } catch {
            print("Failed to save context: \(error)")
        }
        
    }
    
    func updatePoint(user: User, points: Int) {
        
    }
    
    //MARK: TODO
}
