import SwiftUI

struct ModifyProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Information")) {
                    TextField("Name", text: $profileViewModel.name)
                    TextField("Gender", text: $profileViewModel.gender)
                    TextField("Email", text: $profileViewModel.email)
                    TextField("Location", text: $profileViewModel.location)
                }
                
                Section {
                    Button(action: {
                        // Add logic to update the profile
                        profileViewModel.updateProfile()
                    }) {
                        Text("Save Changes")
                    }
                }
            }
            .navigationBarTitle("Modify Profile")
        }
    }
}

class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var gender: String = ""
    @Published var email: String = ""
    @Published var location: String = ""
    
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
