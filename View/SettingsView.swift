import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @State private var selectedFontSizeIndex = 1
    @State private var language = "English"
    @State private var editProfile = false
    @State private var changePassword = false
    @State private var locationEnabled = false
    @State private var mailConfirmationEnabled = true

    let fontSizeOptions = ["Small", "Medium", "Large"]
    let languageOptions = ["English", "Spanish", "French"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Accounts")) {
                    NavigationLink(destination: ProfileView(), isActive: $editProfile) {
                        Button(action: {
                            self.editProfile.toggle()
                        }) {
                            HStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundColor(.green)
                                Text("Edit Profile")
                            }
                        }
                    }

                    NavigationLink(destination: ModifyPasswordView(), isActive: $changePassword) {
                        Button(action: {
                            self.changePassword.toggle()
                        }) {
                            HStack {
                                Image(systemName: "key.fill")
                                    .foregroundColor(.green)
                                Text("Change Password")
                            }
                        }
                    }
                }

                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)

                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .onChange(of: darkModeEnabled, perform: { value in
                            adjustColorScheme()
                        })

                    Picker("Font Size", selection: $selectedFontSizeIndex) {
                        ForEach(0 ..< fontSizeOptions.count) {
                            Text(self.fontSizeOptions[$0])
                        }
                    }

                    Picker("Language", selection: $language) {
                        ForEach(languageOptions, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(header: Text("Location")) {
                    Toggle("Enable Location", isOn: $locationEnabled)
                }

                Section(header: Text("Account")) {
                    Button(action: {
                       
                    }) {
                        HStack {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.red)
                            Text("Delete Account")
                                .foregroundColor(.red)
                        }
                    }
                }


                Section {
                    NavigationLink(destination: ContentView()) {
                        HStack {
                            Image(systemName: "power")
                                .foregroundColor(.red)
                            Text("Log Out")
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
            .preferredColorScheme(darkModeEnabled ? .dark : .light) // Set preferred color scheme
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .accentColor(.green) // Set the accent color to green
        }
        .overlay(
            VStack {
                Spacer()
                HStack {
                    NavigationLink(destination: HomeView()) {
                        Image(systemName: "house.fill")
                            .foregroundColor(.green)
                    }
                    Spacer()
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.green)
                    }
                    Spacer()
                    NavigationLink(destination: CompassView()) {
                        Image(systemName: "location.fill")
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 5)
            }
            .padding()
            .edgesIgnoringSafeArea(.bottom)
        )
        .navigationBarBackButtonHidden(true)

    }
    

    private func adjustColorScheme() {
        if darkModeEnabled {
            UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = .dark
        } else {
            UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = .light
        }
        
    }
    
}


struct EditProfileView: View {
    var body: some View {
        Text("Edit Profile View")
            .navigationBarTitle("Edit Profile")
    }
}

struct ChangePasswordView: View {
    var body: some View {
        Text("Change Password View")
            .navigationBarTitle("Change Password")
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home View")
            .navigationBarTitle("Home")
    }
}

struct CompassView: View {
    var body: some View {
        Text("Compass View")
            .navigationBarTitle("Compass")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

