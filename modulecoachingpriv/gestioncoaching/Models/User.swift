//
//  User.swift
//  modulecoachingpriv
//
//  Created by Farah Metoui on 20/11/2023.
//

import Foundation
struct User: Codable {
    var _id: String
     
       
    var firstname: String
       var lastname: String
       var email: String
       var image: String
       var role: UserRole
       var dateOfBirth: String
       var password: String
       var experienceMonths: Int?
       var certificates: String?
       var latitude: Double?
       var longitude: Double?
       var __v: Int
       enum UserRole: String, Codable {
           case tuteur = "Tuteur"
           case etudiant = "Etudiant"
       }
       
      
       
       
       
}
             
