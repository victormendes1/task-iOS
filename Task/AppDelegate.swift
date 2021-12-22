//
//  AppDelegate.swift
//  Task
//
//  Created by Victor Mendes on 26/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestAuthForLocalNotifications()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func requestAuthForLocalNotifications() {
        notificationCenter.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) { didAllow, error in
            if !didAllow {
                print("User recusou notificações")
            }
        }
    }
    
    func scheduleLocalNotification(_ task: Task) {
        //checking the notification setting whether it's authorized or not to send a request.
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == UNAuthorizationStatus.authorized{
                //1. create contents
                let content = UNMutableNotificationContent()
                content.title = task.title
                content.body = task.notes ?? ""
                content.sound = UNNotificationSound.default
                
                //2. create trigger [calendar, timeinterval, location, pushnoti]
                let dataDue = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute, .second], from: task.date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dataDue, repeats: false)
                //3. make a request
                let id = UUID().uuidString
                let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
                let notificationCenter = UNUserNotificationCenter.current()
                notificationCenter.add(request) { error in
                    if error != nil{
                        print("error in notification! ")
                    }
                }
            }
            else {
                print("user denied")
            }
        }
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
