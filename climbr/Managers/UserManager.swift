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
    
    func getPreferences() -> UserPreferenceModel? {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKey.kUserPreference) else { return nil }
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(UserPreferenceModel.self, from: data)  // Decode back to the struct
            } catch {
                print("Failed to decode user preferences: \(error)")
                return nil
            }
    }
    
    func savePreferences(data: UserPreferenceModel) {
        let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(data)  // Convert to Data
                UserDefaults.standard.set(data, forKey: UserDefaultsKey.kUserPreference)
            } catch {
                print("Failed to encode user preferences: \(error)")
            }
    }
    
    func updatePreferences(data: UserPreferenceModel) {
        let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(data)  // Convert to Data
                UserDefaults.standard.set(data, forKey: UserDefaultsKey.kUserPreference)
            } catch {
                print("Failed to encode user preferences: \(error)")
            }
    }

    
    func getCharacterData() -> CharacterModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CharacterModel.self, from: UserDefaults.standard.data(forKey: UserDefaultsKey.kUserCharacter)!)
            return CharacterModel(name: decodedData.name,
                                  gender: decodedData.gender,
                                  point: decodedData.point,
                                  headEquipment: decodedData.headEquipment,
                                  handEquipment: decodedData.handEquipment,
                                  backEquipment: decodedData.backEquipment,
                                  locationEquipment: decodedData.handEquipment)
        } catch{
            print("Failed to decode user character: \(error)")
            return nil
        }
        
    }
    
    func updateCharacter(with data: CharacterModel) {
        var decodedData: CharacterModel = getCharacterData()!
        
        decodedData.headEquipment = data.headEquipment
        decodedData.backEquipment = data.backEquipment
        decodedData.handEquipment = data.handEquipment
        decodedData.locationEquipment = data.locationEquipment
        
        UserDefaults.standard.setValue(try? JSONEncoder().encode(decodedData), forKey: UserDefaultsKey.kUserCharacter)
    }
    
    func saveCharacterData(data: CharacterModel) {
            let encoder = JSONEncoder()
            do {
                let jsonData = try encoder.encode(data)
                UserDefaults.setValue(jsonData, forKey: UserDefaultsKey.kUserCharacter)
            }catch {
                print("Failed to decode user's character: \(error)")
            }
        }
    
    
    func updatePoint(character: CharacterModel, points: Int) {
        var decodedData: CharacterModel = getCharacterData()!
        
        decodedData.point += Int64(points)
        
        UserDefaults.standard.setValue(try? JSONEncoder().encode(decodedData), forKey: UserDefaultsKey.kUserCharacter)
    }

}
