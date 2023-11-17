// SignupView.swift
import SwiftUI

struct SignupView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var dateOfBirth = Date()
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var agreedToTerms = false
    @State private var agreedToPrivacyPolicy = false
    @State private var selectedRole = "Etudiant" // Default role
    @State private var isPasswordSetupVisible = false

    @ObservedObject var userController = UserController()

    var roles = ["Etudiant", "Tuteur"]

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

                CustomPicker(
                    label: "Role",
                    selection: $selectedRole,
                    options: roles
                )
            }
            .padding()

            // Get Started Button
            Button(action: {
                isPasswordSetupVisible.toggle()
            }) {
                Text("Next")
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
        .sheet(isPresented: $isPasswordSetupVisible) {
            // PasswordSetupView
            VStack {
                CustomTextField(placeholder: "Password", text: $password)
                    .padding()

                CustomTextField(placeholder: "Confirm Password", text: $confirmPassword)
                    .padding()

                // Terms and Conditions
                HStack {
                    Image(systemName: agreedToTerms ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            agreedToTerms.toggle()
                        }
                    Text("I agree to the ")
                    Link("Terms and Conditions", destination: URL(string: "https://marutistoragenew.blob.core.windows.net/msilintiwebpdf/Policy-Terms-and-Conditions.pdf")!)
                }
                .padding()

                // Privacy Policy
                HStack {
                    Image(systemName: agreedToPrivacyPolicy ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            agreedToPrivacyPolicy.toggle()
                        }
                    Text("I agree to the ")
                    Link("Privacy Policy", destination: URL(string: "https://example.com/privacy-policy")!)
                }
                .padding()

                Button(action: {
                    // Validate if the user has agreed to terms and privacy policy before proceeding
                    if agreedToTerms && agreedToPrivacyPolicy {
                        
                        createUser()
                        // Handle button action for confirming terms, privacy policy, and services
                        // You can add your logic here
                    } else {
                        // Show an alert or take appropriate action for not agreeing to terms and privacy policy
                    }
                }) {
                    Text("Create Account")
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green) // Choose a color that fits your design
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
            }
            .padding()
        }
        .padding()
    }

    func createUser() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDateOfBirth = dateFormatter.string(from: dateOfBirth)

        userController.createUser(
            post: Post(
                firstname: firstName,
                lastname: lastName,
                email: email,
                image: "", // You may need to provide a default value or change the structure
                role: selectedRole,
                dateOfBirth: formattedDateOfBirth,
                password: password
            )
        ) { success in
            if success {
                print("User created successfully")
            } else {
                print("Failed to create user")
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

