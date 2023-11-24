import SwiftUI

struct ModifyPasswordView: View {
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
  
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    SecureField("Old Password", text: $oldPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .foregroundColor(.green)

                    SecureField("New Password", text: $newPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .foregroundColor(.green)

                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .foregroundColor(.green)

                    Spacer()

                    Button(action: {
                        // Implement password change logic here
                    }) {
                        Text("Save Changes")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .padding()
            }
            .background(Color(UIColor.systemBackground))
            .navigationBarTitle("Modify Password")
        }
    }
}

struct ModifyPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyPasswordView()
    }
}

