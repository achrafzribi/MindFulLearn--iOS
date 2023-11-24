import SwiftUI

struct ModifyProfileView: View {
    @EnvironmentObject var user: Userviewmodel
    @StateObject var nameViewModel = ProfileViewModel()

        

       


   
    
    var body: some View {
        NavigationView {
            
            VStack{
                TextField("Name", text: $nameViewModel.firstname)
                TextField("Name", text: $nameViewModel.lastname)
                TextField("Name", text: $nameViewModel.email)
                TextField("Name", text: $nameViewModel.dateOfbirth)
                //TextField("Name", text: $nameViewModel.)
                
                
                Section {
                    Button(action: {
                        user.user?.firstname = nameViewModel.firstname
                        user.user?.lastname = nameViewModel.lastname
                        user.user?.email = nameViewModel.email
                        user.user?.dateOfBirth = nameViewModel.dateOfbirth
                        Webservice().updateUser(user: user.user!)
                            { success in
                                print(success)
                        }
                        // Add logic to update the profile
                      
                    }) {
                        Text("Save Changes")
                    }
                }.onAppear{
                    nameViewModel.firstname = user.user!.firstname!
                    nameViewModel.lastname = user.user!.lastname!
                    nameViewModel.email = user.user!.email!
                    nameViewModel.role = user.user!.role!
                    nameViewModel.dateOfbirth = user.user!.dateOfBirth!
                }
            }
            
        }.navigationBarTitle("Modify Profile")
    }
}

class ProfileViewModel: ObservableObject {
    var firstname: String = ""
    @Published var gender: String = ""
    @Published var email: String = ""
    @Published var location: String = ""
    @Published var dateOfbirth : String = ""
    @Published var role : String = ""
    @Published var lastname : String = ""
    // Add necessary methods for updating the profile
    func updateProfile() {
        // Add logic to update the profile using the entered values
        // For example, you can make a network request to update the user's profile on the server
    }
}

struct ModifyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyProfileView()
    }
}

/*struct ProfileView: View {
    var body: some View {
        // Your existing ProfileView code
        // ...
    }
}

struct BasicInfoView: View {
    // Your existing BasicInfoView code
    // ...
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
*/
