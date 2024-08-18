//
//  UserService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation

protocol CharacterService {
    func getPreferences() -> UserPreferences?
    func savePreferences(data: UserPreferenceModel)
    func getCharacterData() -> Character?
    func saveCharacterData(data: UserModel)
    func updatePoint(character: Character, points: Int)
}
