//
//  HealthDietAppApp.swift
//  HealthDietApp
//
//  Created by Arjun Anand on 3/23/24.
//

import SwiftUI
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Permission for push notifications denied.")
            }
        }
        return true
    }
}

struct HealthDietApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FoodItemsManager())
        }
    }
}
