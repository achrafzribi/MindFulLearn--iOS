import SwiftUI

struct ProfileView: View {
    @State private var userData: UserData?

    var body: some View {
        ZStack {
            Color(red: 0.95, green: 1, blue: 0.95)

            VStack(spacing: 30) {
                Image("achraf")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.green, lineWidth: 5))
                    .padding()
                    .onAppear {
                        // Additional onAppear logic if needed
                    }

                Text("Achraf")
                    .font(.system(size: 32))
                    .bold()
                    .foregroundColor(.green)

                // Display user information if available
                if let userData = userData {
                    Text("Name: \(userData.firstname) \(userData.lastname)")
                        .foregroundColor(.black)
                        .padding(.bottom, 10)

                    Text("Email: \(userData.email)")
                        .foregroundColor(.black)
                        .padding(.bottom, 10)

                    Text("Role: \(userData.role)")
                        .foregroundColor(.black)
                        .padding(.bottom, 10)

                    Text("Date of Birth: \(userData.dateOfBirth)")
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                }

                Spacer()

                NavigationLink(destination: ModifyProfileView()) {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(20)
                }
                .offset(x: 0, y: -40)
                .padding()
            }
            .padding()
            .navigationBarTitle("Profile")
            .onAppear {
                // Call the showUser method after successful login
                WebService().showUser { user in
                    if let user = user {
                        self.userData = user
                    } else {
                        // Handle error or show an alert if unable to fetch user data
                    }
                }
            }
        }
    }
}

// Define UserData globally
struct UserData: Decodable {
    var firstname: String
    var lastname: String
    var email: String
    var role: String
    var dateOfBirth: String
}

// Make sure WebService is imported
import Foundation

class WebService {
    func showUser(completion: @escaping (UserData?) -> ()) {
        guard let url = URL(string: "http://localhost:3000/api/user/_id") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let userData = try? JSONDecoder().decode(UserData.self, from: data) {
                completion(userData)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

