import SwiftUI

struct EnterCodeView: View {
    @State private var verificationCode: String = ""

    var body: some View {
        VStack {
            Text("Enter Verification Code")
                .bold()
                .font(.title)
                .padding()

            TextField("Verification Code", text: $verificationCode)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(.green)

            
                
            NavigationLink(destination: NewPasswordView())   {
                Text("Confirm Code")}
                    .foregroundColor(.white)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            

            Spacer()

            Text("Enter the verification code sent to your email.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .padding()
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView()
    }
}

