import Foundation


struct Post: Codable{
    let firstname: String
    let lastname: String
   let email: String
    let image: String
    let role: String
    let dateOfBirth: String
    let password: String

    
}
struct UserData: Codable {
      var role: String?
      var __id: String?
   
        var firstname: String?
        var lastname: String?
        var email: String?
        var image: String?
        var dateOfBirth: String?
        var password: String?
        var createdAt: String?
        var updatedAt: String?
      var __v: Int?

      
}
class Userviewmodel : ObservableObject {
    @Published var user : UserData?
}

