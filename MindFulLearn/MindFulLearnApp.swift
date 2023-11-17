import SwiftUI

@main
struct MindFulLearnApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(UserController())
        }
    }
}

