import SwiftUI

struct ProfileView: View {
   // @State private var userData: UserData?
    @EnvironmentObject var user : Userviewmodel
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.95, green: 1, blue: 0.95)

                VStack(spacing: 30) {
                    Image("achraf")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.green, lineWidth: 5))
                        .padding()
                        .onAppear {
                            // Additional onAppear logic if needed
                        }

                    Text("Achraf")
                        .font(.system(size: 32))
                        .bold()
                        .foregroundColor(.green)

                    // Display user information if available
                    //if let userData = userData {
                        List {
                            Section(header: Text("Basic Information")) {
                                Text("Name: \(user.user!.firstname!) \(user.user!.lastname!)")
                                Text("Email: \(user.user!.email!)")
                                Text("Role: \(user.user!.role!)")
                                Text("Date of Birth: \(user.user!.dateOfBirth!)")
                            
                        }
                        .listStyle(GroupedListStyle())
                        .padding()
                    }

                    Spacer()

                    NavigationLink(destination: ModifyProfileView()) {
                        Text("Edit Profile")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(20)
                    }
                    .offset(x: 0, y: -40)
                    .padding()
                }
                .padding()
                .navigationBarTitle("Profile")
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

