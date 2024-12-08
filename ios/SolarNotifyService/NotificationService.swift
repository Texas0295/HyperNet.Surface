//
//  NotificationService.swift
//  SolarNotifyService
//
//  Created by LittleSheep on 2024/12/8.
//

import UserNotifications
import Intents

enum ParseNotificationPayloadError: Error {
    case missingMetadata(String)
    case missingAvatarUrl(String)
}

class NotificationService: UNNotificationServiceExtension {
    
    private var contentHandler: ((UNNotificationContent) -> Void)?
    private var bestAttemptContent: UNMutableNotificationContent?
    private let serverBaseUrl = "https://api.sn.solsynth.dev"
    
    private func getAttachmentUrl(for identifier: String) -> String {
        identifier.starts(with: "http") ? identifier : "\(serverBaseUrl)/cgi/uc/attachments/\(identifier)"
    }
    
    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {
        self.contentHandler = contentHandler
        guard let bestAttemptContent = request.content.mutableCopy() as? UNMutableNotificationContent else {
            contentHandler(request.content)
            return
        }
        self.bestAttemptContent = bestAttemptContent
        
        do {
            try processNotification(request: request, content: bestAttemptContent)
        } catch {
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
    
    private func processNotification(request: UNNotificationRequest, content: UNMutableNotificationContent) throws {
        switch content.categoryIdentifier {
        case "messaging.message", "messaging.callStart":
            try handleMessagingNotification(request: request, content: content)
        default:
            try handleDefaultNotification(content: content)
        }
    }
    
    private func handleMessagingNotification(request: UNNotificationRequest, content: UNMutableNotificationContent) throws {
        guard let metadata = content.userInfo["metadata"] as? [AnyHashable: Any] else {
            throw ParseNotificationPayloadError.missingMetadata("The notification has no metadata.")
        }
        
        guard var avatarUrl = metadata["avatar"] as? String else {
            throw ParseNotificationPayloadError.missingAvatarUrl("The notification has no avatar.")
        }
        avatarUrl = getAttachmentUrl(for: avatarUrl)
        
        let handle = INPersonHandle(value: "\(metadata["user_id"] ?? "")", type: .unknown)
        let avatar = INImage(url: URL(string: avatarUrl)!)
        let sender = INPerson(
            personHandle: handle,
            nameComponents: nil,
            displayName: content.title,
            image: avatar,
            contactIdentifier: nil,
            customIdentifier: nil
        )
        
        if content.categoryIdentifier == "messaging.callStart" {
            let intent = createCallIntent(with: sender)
            donateInteraction(for: intent)
            let updatedContent = try request.content.updating(from: intent)
            contentHandler?(updatedContent)
        } else {
            let intent = createMessageIntent(with: sender, metadata: metadata, body: content.body)
            donateInteraction(for: intent)
            let updatedContent = try request.content.updating(from: intent)
            contentHandler?(updatedContent)
        }
    }
    
    private func handleDefaultNotification(content: UNMutableNotificationContent) throws {
        guard let metadata = content.userInfo["metadata"] as? [AnyHashable: Any] else {
            throw ParseNotificationPayloadError.missingMetadata("The notification has no metadata.")
        }
        
        if let imageIdentifier = metadata["image"] as? String {
            attachMedia(to: content, withIdentifier: imageIdentifier)
        } else if let avatarIdentifier = metadata["avatar"] as? String {
            attachMedia(to: content, withIdentifier: avatarIdentifier)
        }
        
        contentHandler?(content)
    }
    
    private func attachMedia(to content: UNMutableNotificationContent, withIdentifier identifier: String) {
        let attachmentUrl = getAttachmentUrl(for: identifier)
        if let url = URL(string: attachmentUrl), let attachment = try? UNNotificationAttachment(identifier: identifier, url: url) {
            content.attachments = [attachment]
        }
    }
    
    private func createCallIntent(with sender: INPerson) -> INStartCallIntent {
        INStartCallIntent(
            callRecordFilter: nil,
            callRecordToCallBack: nil,
            audioRoute: .unknown,
            destinationType: .normal,
            contacts: [sender],
            callCapability: .unknown
        )
    }
    
    private func createMessageIntent(with sender: INPerson, metadata: [AnyHashable: Any], body: String) -> INSendMessageIntent {
        INSendMessageIntent(
            recipients: nil,
            outgoingMessageType: .outgoingMessageText,
            content: body,
            speakableGroupName: nil,
            conversationIdentifier: "\(metadata["channel_id"] ?? "")",
            serviceName: nil,
            sender: sender,
            attachments: nil
        )
    }
    
    private func donateInteraction(for intent: INIntent) {
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.direction = .incoming
        interaction.donate(completion: nil)
    }
}
