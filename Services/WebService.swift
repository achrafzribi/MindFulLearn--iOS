//
//  WebService.swift
//  MindFulLearn
//
//  Created by Achraf Zribi on 17/11/2023.
//


import Foundation

class Webservice {
    
    func getPosts(completion: @escaping ([Post]?) -> ()) {
        
        guard let url = URL(string: "http://localhost:3000/api/user/add") else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }.resume()
        
    }
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> ()) {
           // Replace the URL with your actual login endpoint
           guard let url = URL(string: "http://localhost:3000/api/user/login") else {
               completion(false)
               return
           }

           // Create a URLRequest for the login request
           var request = URLRequest(url: url)
           request.httpMethod = "POST" // Use the POST method for login
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")

           // Create a dictionary with email and password
           let credentials = ["email": email, "password": password]
           do {
               request.httpBody = try JSONSerialization.data(withJSONObject: credentials)
           } catch {
               completion(false)
               return
           }

           // Create a URLSession task for the login request
           URLSession.shared.dataTask(with: request) { data, response, error in
               // Handle the response, data, and error
               // Note: In a real app, you'd parse the response data and handle authentication
               // For simplicity, this example only checks if the request was successful (HTTP status code 200)
               if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                   completion(true)
               } else {
                   completion(false)
               }
           }.resume()
       }
    
    func showUser(completion: @escaping (UserData?) -> ()) {
            // Replace the URL with the actual endpoint to fetch user details
            guard let url = URL(string: "http://localhost:3000/api/user/_id") else {
                completion(nil)
                return
            }

            // Create a URLRequest for the showUser request
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // Create a URLSession task for the showUser request
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle the response, data, and error
                if let data = data,
                   let userData = try? JSONDecoder().decode(UserData.self, from: data) {
                    completion(userData)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    
}


