import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""

    var body: some View {
        VStack {
            Text("Forgot Password")
                .bold()
                .font(.title)
                .padding()

            TextField("Email", text: $email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.green)

            NavigationLink(destination: EnterCodeView ()) {
                Text("Send Code")}
                    .foregroundColor(.white)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            

            Spacer()

            Text("An email with instructions to reset your password will be sent to the provided email address.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .padding()
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}

