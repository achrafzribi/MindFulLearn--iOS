import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoggedIn = false  // Added to track login status

    var body: some View {
        NavigationView {
            VStack {
                Text("Join our Community of Learners")
                    .bold()
                    .font(.title)
                    .padding()

                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.green)

                    HStack {
                        ZStack(alignment: .trailing) {
                            if isPasswordVisible {
                                TextField("Password", text: $password)
                                    .padding()
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(.green)
                                    .cornerRadius(10)
                            } else {
                                SecureField("Password", text: $password)
                                    .padding()
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .foregroundColor(.green)
                                    .cornerRadius(10)
                            }

                            Button(action: {
                                // Toggle password visibility
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(.green)
                                    .padding(.trailing, 10)
                            }
                        }
                    }

                    HStack {
                        NavigationLink(destination: ProfileView(), isActive: $isLoggedIn) {
                            EmptyView()
                        }
                        .hidden()

                        Button(action: {
                            // Call the loginUser function
                            loginUser()
                        }) {
                            Text("Login")
                                .foregroundColor(.white)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        NavigationLink(destination: SignupView()) {
                            Text("Sign Up")
                                .foregroundColor(.green)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }

                    NavigationLink(destination: ForgotPasswordView()) {
                        Text("Forgot Password?")
                            .foregroundColor(.green)
                            .padding(.top, 10)
                    }
                }

                Spacer()

                VStack(spacing: 20) {
                    Text("or Sign In with")
                        .foregroundColor(.gray)

                    HStack {
                        Button(action: {
                            // Redirect to Google Sign In
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            // Redirect to Apple Sign In
                        }) {
                            Image(systemName: "applelogo")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }

                    Button(action: {
                        // Redirect to Facebook Sign In
                    }) {
                        Text("f")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension ContentView {
    private func loginUser() {
        // You'll need to replace the following line with the actual URL for your login API
        let loginURL = "http://localhost:3000/api/user/login"
        
        // Check if email and password are not empty
        guard !email.isEmpty, !password.isEmpty else {
            showAlert(message: "Email and password are required.")
            return
        }

        // Make your login request
        Webservice().loginUser(email: email, password: password) { success in
            if success {
                // Set isLoggedIn to true to activate the NavigationLink
                isLoggedIn = true
            } else {
                showAlert(message: "Login failed. Please check your credentials and try again.")
            }
        }
    }

    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SignUpView: View {
    var body: some View {
        Text("Sign Up View")
    }
}

class SignInWithAppleDelegate: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // Handle Apple Sign In success
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle Apple Sign In error
    }
}

