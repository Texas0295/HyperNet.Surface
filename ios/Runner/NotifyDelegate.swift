//
//  NotifyDelegate.swift
//  Runner
//
//  Created by LittleSheep on 2024/12/21.
//

import Foundation
import home_widget
import Alamofire

class NotifyDelegate: UIResponder, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let textResponse = response as? UNTextInputNotificationResponse {
            let content = response.notification.request.content
            guard let metadata = content.userInfo["metadata"] as? [AnyHashable: Any] else {
                return
            }
            
            let channelId = metadata["channel_id"] as? Int
            let eventId = metadata["event_id"] as? Int
            
            let replyToken = metadata["reply_token"] as? String
            
            if (channelId == nil || eventId == nil || replyToken == nil) {
                return;
            }
            
            let serverUrl = "https://api.sn.solsynth.dev"
            let url = "\(serverUrl)/cgi/im/quick/\(channelId!)/reply/\(eventId!)?replyToken=\(replyToken!)"
            
            let parameters: [String: Any] = [
                "type": "messages.new",
                "body": [
                    "text": textResponse.userText,
                    "algorithm": "plain"
                ]
            ]
            
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate()
                .responseString { response in
                    switch response.result {
                    case .success(_):
                        break
                    case .failure(let error):
                        print("Failed to send chat reply message: \(error)")
                        break
                    }
                }
        }
        
        completionHandler()
    }
}
