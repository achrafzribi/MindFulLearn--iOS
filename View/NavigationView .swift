import SwiftUI

struct NavigationView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Your content goes here
                
                NavigationLink(destination: LoginView()) {
                    Text("Go to Second Page")
                }
            }
            .navigationTitle("First Page")
        }
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            // Your content for the second page
            
            Text("This is the Second Page")
        }
        .navigationTitle("Second Page")
    }
}

