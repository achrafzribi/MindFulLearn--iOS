//
//  modulecoachingprivApp.swift
//  modulecoachingpriv
//
//  Created by yahya fhima on 6/11/2023.
//


import SwiftUI
@main
struct modulecoachingprivApp: App {
    
    
    let persistenceController = PersistenceController.shared
    @StateObject var locationViewModel = Locationsearchviewmodel();
    @StateObject var user = Userviewmodel();
    
    var body: some Scene {
        
        WindowGroup {
            WelcomeView()
                .environmentObject(locationViewModel)
                .environmentObject(user)
                
        }
    }
}
