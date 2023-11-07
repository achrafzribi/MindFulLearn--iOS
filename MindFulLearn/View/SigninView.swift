import SwiftUI

struct SignupView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack {
            // Top Section
            ZStack {
                Color.green
                    .frame(height: 3 * UIScreen.main.bounds.height / 10)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Unlock your full potential")
                        .bold()
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                    
                    Text("Join today and start your journey")
                        .foregroundColor(.white)
                        .padding(.bottom)
                }
            }
            
            // TextFields
            VStack(spacing: 20) {
                TextField("First Name", text: $firstName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                TextField("Last Name", text: $lastName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                DatePicker("Date of Birth", selection: $dateOfBirth, in: ...Date(), displayedComponents: .date)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .padding()
            
            // Get Started Button
            Button(action: {
                // Handle Get Started
            }) {
                Text("Get Started")
                    .foregroundColor(.black)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .border(Color.black, width: 1)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

