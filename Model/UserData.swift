//
//  UserData.swift
//  MindFulLearn
//
//  Created by Achraf Zribi on 17/11/2023.
//

import Foundation
struct UserData: Codable {
    let firstname: String
    let lastname: String
    let email: String
    let image: String
    let role: String
    let dateOfBirth: String
    let password: String
}
