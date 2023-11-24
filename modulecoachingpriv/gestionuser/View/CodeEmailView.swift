import SwiftUI
import Alamofire
struct EnterCodeView: View {
    @State private var verificationCode: String = ""
    var email : String
    @State   var varcode : String = ""
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

            
            if(verificationCode == varcode){
                NavigationLink(destination: NewPasswordView(email : email))   {
                    Text("Confirm Code")}
                .foregroundColor(.white)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
            }

            Spacer()

            Text("Enter the verification code sent to your email.")
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }.onAppear{
            print("test"+email)
            sendForgotPasswordRequest()
        }
        .padding()
    }
    func sendForgotPasswordRequest() {
        print("test"+email)
       let apiUrl = "http://172.18.6.106:3000/api/user/forgotpassword/sendcode"
       let parameters = ["email": email]
     
       AF.request(apiUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default)
           .responseJSON { response in
               switch response.result {
               case .success(let value):
                   print("API Success: \(value)")
                   self.varcode = value as! String
                   // Handle the success response here
               case .failure(let error):
                   print("API Failure: \(error)")
                   // Handle the error here
               }
           }
   }
}




