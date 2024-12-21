//
//  NotifyDelegate.swift
//  Runner
//
//  Created by LittleSheep on 2024/12/21.
//

import Foundation
import home_widget

class NotifyDelegate: UIResponder, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let textResponse = response as? UNTextInputNotificationResponse {
            let content = response.notification.request.content
            guard let metadata = content.userInfo["metadata"] as? [AnyHashable: Any] else {
                return
            }
            
            let channelId = metadata["channel_id"] as? Int
            let eventId = metadata["event_id"] as? Int
            
            
            if #available(iOS 17, *) {
                Task {
                    await HomeWidgetBackgroundWorker.run(
                        url: URL(string: "solink:///chat/reply")?.appending(queryItems: [
                            URLQueryItem(name: "channel_id", value: String(channelId ?? 0)),
                            URLQueryItem(name: "event_id", value: String(eventId ?? 0)),
                            URLQueryItem(name: "text", value: textResponse.userText)
                        ]),
                        appGroup: "group.solsynth.solian"
                    )
                }
            } else {
                // Fallback on earlier versions
            }
        }
        
        completionHandler()
    }
}
