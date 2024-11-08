//
//  UserManager.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation
import CoreData

class UserManager : CharacterService {
  
  static let shared = UserManager()
  
  var character: CharacterModel!
  var preferences: UserPreferenceModel!
  
  private init() {
    character = getCharacterData()
    preferences = getPreferences()
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
      guard let coba = UserDefaults.standard.data(forKey: UserDefaultsKey.kUserCharacter) else { return nil }
      let decodedData = try decoder.decode(CharacterModel.self, from: coba)
      return CharacterModel(name: decodedData.name,
                            gender: decodedData.gender,
                            point: decodedData.point,
                            headEquipment: decodedData.headEquipment,
                            handEquipment: decodedData.handEquipment,
                            backEquipment: decodedData.backEquipment,
                            locationEquipment: decodedData.locationEquipment)
    } catch{
      print("Failed to decode user character: \(error)")
      return nil
    }
    
  }
  
  func updateCharacter(with data: CharacterModel) {
    do {
      let encodedData = try JSONEncoder().encode(data)
      
      UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsKey.kUserCharacter)
    } catch {
      print("Error: ", error.localizedDescription)
    }
  }
  
  func saveCharacterData(data: CharacterModel) {
    let encoder = JSONEncoder()
    do {
      let jsonData = try encoder.encode(data)
      UserDefaults.standard.set(jsonData, forKey: UserDefaultsKey.kUserCharacter)
    }catch {
      print("Failed to decode user's character: \(error)")
    }
  }
  
  
  func updatePoint(character: CharacterModel, points: Int) {
    var decodedData: CharacterModel = getCharacterData()!
    
    do {
        print("Point before update: \(decodedData.point)")
      decodedData.point += points
        print("Point after update: \(decodedData.point)")
      let encodedData = try JSONEncoder().encode(decodedData)
      UserDefaults.standard.set(encodedData, forKey: UserDefaultsKey.kUserCharacter)
    } catch {
      print("Error: ", error.localizedDescription)
    }
  }
  
}
