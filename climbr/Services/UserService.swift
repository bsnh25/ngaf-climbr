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
    func updatePreferences(data: UserPreferenceModel)
    func getCharacterData() -> CharacterModel?
    func saveCharacterData(data: CharacterModel)
    func updateCharacter(with data: CharacterModel)
    func updatePoint(character: CharacterModel, points: Int)
}
