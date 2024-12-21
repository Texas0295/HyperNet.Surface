import Flutter
import UIKit

import workmanager

@main
@objc class AppDelegate: FlutterAppDelegate {
    let notifyDelegate = NotifyDelegate()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        WorkmanagerPlugin.setPluginRegistrantCallback { registry in
            GeneratedPluginRegistrant.register(with: registry)
        }
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*5))
        
        UNUserNotificationCenter.current().delegate = notifyDelegate
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

}
