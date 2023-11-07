import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView{
            VStack {
                // Static Image
                Image("your_static_image_name")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Text and Button
                VStack {
                    Text("MindfulLearn")
                        .font(.title)
                        .bold()
                    
                    Text("Unlock your full potential with comprehensive courses and activities")
                        .multilineTextAlignment(.center)
                        .padding()
                    NavigationLink(destination: ContentView()) {
                            Text("Start Learning")
                                        .foregroundColor(.white)
                                                .bold()
                                                .frame(maxWidth: .infinity)
                                                .padding()
                                                .background(Color.green)
                                                .cornerRadius(10)
                                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
    }
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

