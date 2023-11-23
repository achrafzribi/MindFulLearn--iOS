import Foundation
import Alamofire
struct UserDetail: Codable {
    let role: String?
      let _id: String?
      let firstname: String?
      let lastname: String?
      let email: String?
      let image: String?
      let dateOfBirth: String?
      let password: String?
      let createdAt: String?
      let updatedAt: String?
      let __v: Int?
    // Add more properties if needed
}
struct Responsefetch: Codable{
    var statusCode : Int
   var  message : String
    var role: String
    let __id: String
 
      let firstname: String
      let lastname: String
      let email: String
      let image: String
      let dateOfBirth: String
      let password: String
      let createdAt: String
      let updatedAt: String
    let __v: String
    

}
// Define UserData globally


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
    
    func loginUser(email: String, password: String, completion: @escaping (UserData) -> ()) {
        // Replace the URL with your actual login endpoint
        let apiUrl = "http://localhost:3000/api/user/login"
        
        let parameters: [String: Any] = ["email": email, "password": password]
        
        AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let topLevelContainer = try JSONDecoder().decode(Responsefetch.self, from: data)
                        
                        let user = UserData(
                            role: topLevelContainer.role,
                            __id: topLevelContainer.__id,
                            firstname: topLevelContainer.firstname,
                            lastname: topLevelContainer.lastname,
                            email: topLevelContainer.email,
                            image: topLevelContainer.image,
                            dateOfBirth: topLevelContainer.dateOfBirth,
                            password: topLevelContainer.password,
                            createdAt: topLevelContainer.createdAt,
                            updatedAt: topLevelContainer.updatedAt,
                            __v: Int(topLevelContainer.__v as String))
                        print(user)
                        completion(user)
                    } catch let decodingError {
                        print("Decoding Error: \(decodingError)")
                        print(decodingError)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        
        
            }
        
        
        func showUser(completion: @escaping (UserData?) -> ()) {
            // Replace the URL with the actual endpoint to fetch user details
            guard let url = URL(string: "http://localhost:3000/api/user/find/6556d25c7642485ca411f94c") else {
                completion(nil)
                return
            }
            
            /* var request = URLRequest(url: url)
             request.httpMethod = "GET"
             request.addValue("application/json", forHTTPHeaderField: "Content-Type")
             */
            AF.request("http://localhost:3000/api/user/find/6556d25c7642485ca411f94c", method: .get)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let topLevelContainer = try JSONDecoder().decode(Responsefetch.self, from: data)
                            
                            let user = UserData(
                                role: topLevelContainer.role,
                                __id: topLevelContainer.__id,
                                firstname: topLevelContainer.firstname,
                                lastname: topLevelContainer.lastname,
                                email: topLevelContainer.email,
                                image: topLevelContainer.image,
                                dateOfBirth: topLevelContainer.dateOfBirth,
                                password: topLevelContainer.password,
                                createdAt: topLevelContainer.createdAt,
                                updatedAt: topLevelContainer.updatedAt,
                                __v: Int(topLevelContainer.__v as String))
                            print(user)
                            completion(user)
                        } catch let decodingError {
                            print("Decoding Error: \(decodingError)")
                            print(decodingError)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            
            
            
        }
        
        func deleteUser(user: UserData, completion: @escaping (Bool) -> ()) {
            guard let userId = getUserId() else {
                completion(false)
                return
            }

            let url = URL(string: "http://localhost:3000/api/user/\(user.__id!)")!

            AF.request(url, method: .delete)
                .validate()
                .response { response in
                    if response.error == nil {
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
        }

            func getUserId() -> String? {
                return UserDefaults.standard.string(forKey: "userId") ?? ""
            }
    func ChangePassword(email: String, password: String, completion: @escaping (String) -> ()) {
        // Replace the URL with your actual login endpoint
        let apiUrl = "http://localhost:3000/api/user/password"
       print(email)
        let parameters: [String: Any] = ["email": email, "password": password]
        
        AF.request(apiUrl, method: .put, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    print("success")
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        
        
            }
        }
        

func updateUser(user: UserData, completion: @escaping (Bool) -> ()) {
     let url = URL(string: "http://localhost:3000/api/user/update/\(user.__id!)")

    AF.request(url!, method: .put, parameters: user, encoder: JSONParameterEncoder.default)
         .validate()
         .response { response in
             if response.error == nil {
                 completion(true)
             } else {
                 completion(false)
             }
         }
    
 }



func sendForgotPasswordRequest() {
    let apiUrl = "http://localhost:3000/api/user/forgotpassword/sendcode"
    let parameters = ["email": "mohamedachraf.zribi@esprit.tn"]

    AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("API Success: \(value)")
                // Handle the success response here
            case .failure(let error):
                print("API Failure: \(error)")
                // Handle the error here
            }
        }
}






