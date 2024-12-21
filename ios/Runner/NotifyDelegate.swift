//
//  NotifyDelegate.swift
//  Runner
//
//  Created by LittleSheep on 2024/12/21.
//

import Foundation

class NotifyDelegate: UIResponder, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let textResponse = response as? UNTextInputNotificationResponse {
            let userText = textResponse.userText
            print("User replied: \(userText)")
            // Handle the reply text
        }
        
        completionHandler()
    }
}
