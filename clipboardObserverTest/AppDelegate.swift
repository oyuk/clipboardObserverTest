//
//  AppDelegate.swift
//  clipboardObserverTest
//
//  Created by oky on 2015/01/23.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate ,GLPasteboardMonitorDelegate{

    var window: UIWindow?
    var monitor:GLPasteboardMonitor?
    var backgroundTask:UIBackgroundTaskIdentifier?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let settings = UIUserNotificationSettings(
            forTypes: UIUserNotificationType.Badge
                | UIUserNotificationType.Sound
                | UIUserNotificationType.Alert,
            categories: nil)
        application.registerUserNotificationSettings(settings);
        
        
        let allowedType = settings.types
        switch allowedType {
        case UIUserNotificationType.None:
            println("何も認証されていない")
        case UIUserNotificationType.Sound:
            println("認証された")
        default:
            println("default")
        }
        
        
        monitor = GLPasteboardMonitor(delegate: self)
        monitor?.run()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        
        backgroundTask = application.beginBackgroundTaskWithExpirationHandler({
            application.endBackgroundTask(self.backgroundTask!)
            self.backgroundTask = UIBackgroundTaskInvalid
        })
    }

     // MARK: -  GLPasteboardMonitor
   
    func pasteboardMonitor(Monitor: GLPasteboardMonitor!, didChangeString newCopiedString: String!) {
    
        let localNotification = UILocalNotification()
        
        
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = "copied a string now \(newCopiedString)"
        
        UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)
        
        if let pasteBoardString = UIPasteboard.generalPasteboard().valueForPasteboardType("public.text") as? String {
                        Strings.sharedInstance.addStrings(newCopiedString)
         }

        
        
    }
    
    func pasteboardMonitor(Monitor: GLPasteboardMonitor!, didChangeImage newCopiedImage: UIImage!) {
        
    }
    
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
//        let pasteBoard = UIPasteboard.generalPasteboard()
//        
//        if let pasteBoardString = pasteBoard.valueForPasteboardType("public.text") as? String {
//            Strings.sharedInstance.addStrings(pasteBoardString)
//        }
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        NSLog("applicationWillTerminate")
        
        let localNotification = UILocalNotification()
    
        
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = "applicationWillTerminate"
        
        UIApplication.sharedApplication().presentLocalNotificationNow(localNotification)

    }


}

