import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @State private var appleSignInDelegate: SignInWithAppleDelegate?
    
        @State private var isSignInViewActive = false


    var body: some View {
        VStack {
            HStack {
                Text("Learn More")
                    .foregroundColor(.black)
                    .padding()

                Spacer()
            }

            Text("Join our Community of Learners")
                .bold()
                .font(.title)
                .padding()

            VStack(spacing: 20) {
                Button(action: {
                    // Redirect to Google Sign In
                    if let url = URL(string: "https://accounts.google.com/ServiceLogin") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Google Sign In")
                        .foregroundColor(.black)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .border(Color.black, width: 1)
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
                    Text("Apple Sign In")
                        .foregroundColor(.black)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .border(Color.black, width: 1)
                        .cornerRadius(10)
                }

                Button(action: {
                    // Redirect to Facebook Sign In
                    // Replace "your_facebook_app_id" with your actual Facebook App ID
                    if let url = URL(string: "https://www.facebook.com/v10.0/dialog/oauth?client_id=your_facebook_app_id&redirect_uri=https://www.facebook.com/connect/login_success.html") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Facebook Sign In")
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }

            Text("or Sign In using Email")
                .padding()

            TextField("Email", text: .constant(""))
                .padding()

            
            Button(action: {
                // Handle Continue with Email
                isSignInViewActive = true
                
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .background(
                            NavigationLink(
                                destination: SignupView(),
                                isActive: $isSignInViewActive,
                                label: EmptyView.init
                            )
                        )
            
            Spacer()

            Text("By signing in, you agree to our Terms of Service and Privacy Policy.")
                .foregroundColor(.gray)
                .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

