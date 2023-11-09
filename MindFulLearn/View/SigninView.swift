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
            // Title
            Text("Create an Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            // TextFields
            VStack(spacing: 15) {
                CustomTextField(placeholder: "First Name", text: $firstName)
                CustomTextField(placeholder: "Last Name", text: $lastName)
                CustomDatePicker(label: "Date of Birth", selectedDate: $dateOfBirth)
                CustomTextField(placeholder: "Email", text: $email)
                CustomPicker(label: "Role", selection: $selectedRole, options: roles)

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
                    .foregroundColor(.white)
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

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct CustomDatePicker: View {
    var label: String
    @Binding var selectedDate: Date

    var body: some View {
        DatePicker(label, selection: $selectedDate, in: ...Date(), displayedComponents: .date)
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct CustomPicker: View {
    var label: String
    @Binding var selection: String
    var options: [String]

    var body: some View {
        Picker(label, selection: $selection) {
            ForEach(options, id: \.self) {
                Text($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

