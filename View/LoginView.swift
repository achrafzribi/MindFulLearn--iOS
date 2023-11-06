import SwiftUI

struct ContentView: View {
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
                    // Handle Google Sign In
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
                    // Handle Apple Sign In
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
                    // Handle Facebook Sign In
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
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
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

