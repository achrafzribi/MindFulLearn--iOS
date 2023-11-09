import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible = false
    @State private var rememberMe = false
    @State private var appleSignInDelegate: SignInWithAppleDelegate?

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

                    Toggle("Remember Me", isOn: $rememberMe)
                        .foregroundColor(.green)
                        .padding(.leading, 10)

                    HStack {
                        Button(action: {
                            // Handle Continue with Email
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
                            Image("google") // Replace with the actual Google logo
                                .resizable()
                                .frame(width: 170, height: 60) // Adjusted size
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            // Redirect to Apple Sign In
                        }) {
                            Image("apple_logo") // Replace with the actual Apple logo
                                .resizable()
                                .frame(width: 170, height: 60) // Adjusted size
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }

                    Button(action: {
                        // Redirect to Facebook Sign In
                    }) {
                        Image("facebook_logo") // Replace with the actual Facebook logo
                            .resizable()
                            .frame(width: 250, height: 60) // Adjusted size
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
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

