//
//  UserService.swift
//  climbr
//
//  Created by Fatakhillah Khaqo on 08/08/24.
//

import Foundation

protocol UserService {
    func getPreferences() -> UserPreferences
    func savePreferences(data: UserPreferences)
    func getUserData() -> User
    func saveUserData(data: User)
    func updatePoint(user: User, points: Int)
}
