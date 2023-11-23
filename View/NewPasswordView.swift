import SwiftUI

struct NewPasswordView: View {
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State var  changedpass: Bool = false
    var email : String
    var body: some View {
        NavigationView {
            VStack {
                Text("Create New Password")
                    .bold()
                    .font(.title)
                    .padding()
                
                SecureField("New Password", text: $newPassword)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.green)
                
                SecureField("Confirm New Password", text: $confirmPassword)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.green)
                NavigationLink(
                    destination: ContentView(), // Pass the email to DetailView
                    isActive: $changedpass
                    
                    
                ) {
                    EmptyView()
                }
                Button(action: {
                    Webservice().ChangePassword(email: email, password:confirmPassword ){ success in
                      
                            print(success)
                            
                       print(changedpass)
                    }
                    changedpass.toggle()
                    // Handle new password confirmation logic
                }) {
                    Text("Save Password")
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                Text("Your new password must be at least 8 characters long and match the confirmation.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}



