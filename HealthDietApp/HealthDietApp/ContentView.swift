//
//  ContentView.swift
//  ContentView
//
//  Created by J L on 3/23/24.
//

import SwiftUI
import UIKit
import UserNotifications

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem() {
                    Image(systemName: "house.fill")
                }
            Profile()
                .tabItem() {
                    Image(systemName: "person.fill")
                }
            Settings()
                .tabItem() {
                    Image(systemName: "gearshape.fill")
                }
        }
        .environmentObject(FoodItemsManager())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class ViewController: UIViewController {
    override func viewDidLoad(){
        super.viewDidLoad()
        
    }
    
    func checkforPermissions() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return;
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]){
                    didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            default:
                return
            }
        }
    }
    
    func dispatchNotification() {
        let identifier = "my-morning-notif"
        let title = "Time to eat Breakfast!"
        let body = "What did you eat for breakfast? Record it!"
        let isDaily = true
        
        let hour1 = 12
        let minute1 = 0;
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        
        let content = UNMutableNotificationContent()
        content.title = title;
        content.body = body;
        content.sound = .default
        
        let calendar = Calendar.current
        var date = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        date.hour = hour1
        date.minute = minute1
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers:[identifier])
        notificationCenter.add(request)
    }
}
