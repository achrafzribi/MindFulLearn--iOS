import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible = false
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
                        }
                        .padding(.trailing, 10) // Adjust the padding based on your preference
                    }

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

                    // Navigate to ForgotPasswordView
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
                            if let url = URL(string: "https://accounts.google.com/ServiceLogin") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("Google")
                                .foregroundColor(.white)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }

                        Button(action: {
                            // Redirect to Apple Sign In
                            let request = ASAuthorizationAppleIDProvider().createRequest()
                            appleSignInDelegate = SignInWithAppleDelegate()
                            let controller = ASAuthorizationController(authorizationRequests: [request])
                            controller.delegate = appleSignInDelegate
                            controller.performRequests()
                        }) {
                            Text("Apple")
                                .foregroundColor(.white)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }

                    Button(action: {
                        // Redirect to Facebook Sign In
                        // Replace "your_facebook_app_id" with your actual Facebook App ID
                        if let url = URL(string: "https://www.facebook.com/v10.0/dialog/oauth?client_id=your_facebook_app_id&redirect_uri=https://www.facebook.com/connect/login_success.html") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("Facebook")
                            .foregroundColor(.white)
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SignUpView: View {
    var body: some View {
        // Your Sign-Up View here
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

