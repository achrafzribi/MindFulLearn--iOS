//
//  UserController.swift
//  MindFulLearn
//
//  Created by Achraf Zribi on 17/11/2023.
//

import Foundation

class UserController: ObservableObject {
    let webservice = Webservice()

    func createUser(post: Post, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: "http://localhost:3000/api/user/add") else {
            fatalError("Invalid URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(post)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user data: \(error)")
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }

            // Optionally, you can handle the response if needed
            // let responseString = String(data: data, encoding: .utf8)
            // print("Response: \(responseString)")

            // Assuming the API returns a success indicator, update completion accordingly
            let success = true
            DispatchQueue.main.async {
                completion(success)
            }

        }.resume()
    }
}
