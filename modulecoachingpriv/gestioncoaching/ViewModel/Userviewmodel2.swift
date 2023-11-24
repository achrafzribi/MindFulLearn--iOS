//
//  Useviewmodel.swift
//  modulecoachingpriv
//
//  Created by Farah Metoui on 20/11/2023.
//

import Foundation
import SwiftUI
import Alamofire

class Userviewmodel2: ObservableObject {
    @Published var users: [User] = []
    @Published var annotation: Int  = 0
    let baseURL = "http://192.168.1.4:3000/api/tuteur" // Replace with your API endpoint
    
    func fetchUsers() {
        AF.request(baseURL, method: .get)
            .validate() // Validate the response
            .responseDecodable(of: [User].self) { response in
                switch response.result {
                case .success(let fetchedUsers):
                    DispatchQueue.main.async {
                        
                     //   print(fetchedUsers)
                        self.users = fetchedUsers
                        
                        print(self.users)
                    }
                case .failure(let error):
                    print("Error fetching users: \(error.localizedDescription)")
                }
            }
    }
}
