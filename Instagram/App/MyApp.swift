//
//  MyApp.swift
//  Instagram
//
//  Created by Sahil Prasad on 20/10/26.
//

import SwiftUI
import FirebaseCore

// MARK: - Firebase App Delegate
/// App launch hote hi Firebase ko initialize (setup) karne ke liye AppDelegate use hota hai.
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Firebase SDK ko start karta hai
        FirebaseApp.configure()
        return true
    }
}

// MARK: - Main App Entry Point
/// `@main` batata hai ki humari app yahan se start hogi.
@main
struct MyApp: App {
    
    // AppDelegate ko SwiftUI app life-cycle ke saath connect karta hai
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            // App ki sabse pehli screen (Root View)
            ContentView()
        }
    }
}
