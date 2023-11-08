import SwiftUI

struct SignupView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var selectedRole = "Etudiant" // Default role

    var roles = ["Etudiant", "Tuteur"]

    var body: some View {
        VStack {
            // TextFields
            VStack(spacing: 10) {
                TextField("First Name", text: $firstName)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5)

                TextField("Last Name", text: $lastName)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5)

                DatePicker("Date of Birth", selection: $dateOfBirth, in: ...Date(), displayedComponents: .date)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5)

                Picker("Role", selection: $selectedRole) {
                    ForEach(roles, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
                .shadow(radius: 5)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5)

                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .shadow(radius: 5)
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
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

