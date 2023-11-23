import SwiftUI

@main
struct MindFulLearnApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var user = Userviewmodel();
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(user)
        }
    }
}

