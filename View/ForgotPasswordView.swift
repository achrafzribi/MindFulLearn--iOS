import SwiftUI
import Alamofire

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
            
            
          
                NavigationLink(
                    destination: EnterCodeView(email : email),
                                    label: {
                   Text("send")
                    
                
              
                
            })
            

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

