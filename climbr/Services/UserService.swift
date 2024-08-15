//
//  UserService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation

protocol UserService {
    func getPreferences() -> UserPreferences?
    func savePreferences(data: UserPreferenceModel)
    func getUserData() -> User?
    func saveUserData(data: UserModel)
    func updatePoint(user: User, points: Int)
}
