  //
//  AppDelegate.swift
//  CodedayProject
//
//  Created by Arnav Chawla on 2/18/17.
//  Copyright © 2017 Arnav Chawla. All rights reserved.
//

import UIKit

import GoogleSignIn
import UserNotifications    
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
  import FBSDKCoreKit
  import FacebookCore
  import FacebookLogin
  import FBSDKCoreKit
var s  = false
var p = false
var se = false
var os = false
var ip1 = false
var ipb = false
@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let gcmMessageIDKey = "gcm.message_id"

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            // For iOS 10 data message (sent via FCM)
            FIRMessaging.messaging().remoteMessageDelegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // [END register_for_notifications]
        FIRApp.configure()
        
        // [START add_token_refresh_observer]
        // Add observer for InstanceID token refresh callback.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .firInstanceIDTokenRefresh,
                                               object: nil)
        // [END add_token_refresh_observer]
        let settings : UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        let storyboard: UIStoryboard = self.grabStoryboard()
        // display storyboard
        self.window!.rootViewController = storyboard.instantiateInitialViewController()
        self.window!.makeKeyAndVisible()

        return true
    }
    func grabStoryboard() -> UIStoryboard {
        // determine screen size
        let screenHeight: CGFloat = UIScreen.main.bounds.size.height
        var storyboard: UIStoryboard
        switch screenHeight {
        // iPhone 4s
        case 480:
            storyboard = UIStoryboard(name: "4s", bundle: nil)
            os = true
        // iPhone 5s
        case 568:
            storyboard = UIStoryboard(name: "se", bundle: nil)
            se = true
            
        // iPhone 6
        case 667:
            storyboard = UIStoryboard(name: "Main", bundle: nil)
            s = true
            
        // iPhone 6 Plus
        case 736:
            storyboard = UIStoryboard(name: "big", bundle: nil)
            p = true
        case 2048:
            storyboard = UIStoryboard(name: "ipad1", bundle: nil)
            ip1 = false
        case 2732:
            storyboard = UIStoryboard(name: "ipadbig", bundle: nil)
            ipb = true
        default:
            // it's an iPad
            storyboard = UIStoryboard(name: "Main", bundle: nil)
        }
        
        return storyboard
    }
    // [START receive_message]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        FBSDKAppEvents.activateApp()
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    // [END receive_message]
    // [START refresh_token]
    func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    // [END refresh_token]
    // [START connect_to_fcm]
    func connectToFcm() {
        // Won't connect since there is no token
        guard FIRInstanceID.instanceID().token() != nil else {
            return;
        }
        
        // Disconnect previous FCM connection if it exists.
        FIRMessaging.messaging().disconnect()
        
        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
            }
        }
    }
    // [END connect_to_fcm]
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the InstanceID token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.sandbox)
    }
    
    // [START connect_on_active]
    func applicationDidBecomeActive(_ application: UIApplication) {
        connectToFcm()
    }
    // [END connect_on_active]
    // [START disconnect_from_fcm]
    func applicationDidEnterBackground(_ application: UIApplication) {

        let priority = DispatchQueue.GlobalQueuePriority.default
        DispatchQueue.global(priority: priority).async(execute: {
            
            var databaseRef = FIRDatabase.database().reference()
            let uid = FIRAuth.auth()?.currentUser?.uid
            databaseRef.child("posts").child(uid!).queryLimited(toLast: 1).observe(.childAdded, with: {
                snapshot in
                var username = ""
                var bodyText = ""
                if let dict = snapshot.value as? [String: AnyObject]
                {
                    let mediaType = dict["MediaType"] as! String
                    let senderId = dict["senderId"] as! String
                    let senderName = dict["senderName"] as! String
                    username = senderName
                    
                    let t = dict["text"] as! String
                    bodyText = t
                }
                DispatchQueue.main.async(execute: {
                    
                    let notification = UILocalNotification()
                    notification.alertTitle = username
                    notification.alertBody = bodyText
                
                    notification.alertAction = "open"
                    notification.soundName = UILocalNotificationDefaultSoundName
                    notification.fireDate = Date(timeIntervalSinceNow: 0)
                    
                    UIApplication.shared.scheduleLocalNotification(notification)
                    
                
                })
                
            })
            
            
        })

        FIRMessaging.messaging().disconnect()
        print("Disconnected from FCM.")
    }
    // [END disconnect_from_fcm]

}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]
// [START ios_10_data_message_handling]
extension AppDelegate : FIRMessagingDelegate {
    // Receive data message on iOS 10 devices while app is in the foreground.
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
}




