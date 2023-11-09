import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack { // Use a ZStack to layer the background color and content
            Color(red: 0.95, green: 1, blue: 0.95) // Light green background color

            VStack(spacing: 30) { // Increase spacing between elements for a more spacious layout
                Image("achraf")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200) // Increase image size for better visual impact
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.green, lineWidth: 5)) // Add a green border around the image
                    .padding() // Add padding around the image for better visual separation

                Text("Achraf")
                    .font(.system(size: 32)) // Use a larger font size for the name
                    .bold()
                    .foregroundColor(.green) // Use a darker shade of green for better contrast

                BasicInfoView(name: "Achraf", gender: "Male", email: "achraf@example.com", location: "Morocco")
                    .padding() // Add padding to the BasicInfoView for better visual separation

                Spacer() // Add a spacer to push the Edit Profile button to the bottom

                NavigationLink(destination: ModifyProfileView()) {
                    Text("Edit Profile")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green) // Use a darker shade of green for better contrast
                        .cornerRadius(20) // Increase the button's corner radius for a smoother look
//                        .shadow(color: Color.gray.opacity(0.5), radius: 5, offset: .bottom) // Add a subtle shadow to the button
                }
                .offset(x: 0, y: 20) // Offset the Edit Profile button vertically by 20 points
                .padding() // Add padding to the Edit Profile button for better visual separation
            }
            .padding() // Add padding to the entire view for a more spacious feel
            .navigationBarTitle("Profile") // Use a larger font size for the navigation bar title
        }
    }
}

struct BasicInfoView: View {
    var name: String
    var gender: String
    var email: String
    var location: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) { // Increase spacing between info labels and values
            Text("Basic Information")
                .font(.headline)
                .foregroundColor(Color.green) // Use a darker shade of green for better contrast
                .padding(.bottom, 5)

            HStack {
                Text("Name:")
                    .foregroundColor(Color.gray)
                Text(name)
                    .foregroundColor(.black) // Use a darker color for the info values for better readability
            }

            HStack {
                Text("Gender:")
                    .foregroundColor(Color.gray)
                Text(gender)
                    .foregroundColor(.black)
            }

            HStack {
                Text("Email:")
                    .foregroundColor(Color.gray)
                Text(email)
                    .foregroundColor(.black)
            }

            HStack {
                Text("Location:")
                    .foregroundColor(Color.gray)
                Text(location)
                    .foregroundColor(.black)
            }
        }
        .padding(.bottom, 20)
    }
}

struct editProfileView: View {
    var body: some View {
        Text("Edit Profile View")
            .navigationBarTitle("Edit Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}

