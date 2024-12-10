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
    
    private func fetchAvatarImage(from url: String, completion: @escaping (INImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        // Define a cache location based on the URL hash
        let cacheFileName = imageURL.lastPathComponent
        let tempDirectory = FileManager.default.temporaryDirectory
        let cachedFileUrl = tempDirectory.appendingPathComponent(cacheFileName)
        
        // Check if the image is already cached
        if FileManager.default.fileExists(atPath: cachedFileUrl.path) {
            do {
                let data = try Data(contentsOf: cachedFileUrl)
                let cachedImage = INImage(imageData: data) // No optional binding here
                completion(cachedImage)
                return
            } catch {
                print("Failed to load cached avatar image: \(error.localizedDescription)")
                try? FileManager.default.removeItem(at: cachedFileUrl) // Clear corrupted cache
            }
        }
        
        // Download the image if not cached
        let session = URLSession(configuration: .default)
        session.downloadTask(with: imageURL) { localUrl, response, error in
            if let error = error {
                print("Failed to fetch avatar image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let localUrl = localUrl, let data = try? Data(contentsOf: localUrl) else {
                print("Failed to fetch data for avatar image.")
                completion(nil)
                return
            }
            
            do {
                // Cache the downloaded file
                try FileManager.default.moveItem(at: localUrl, to: cachedFileUrl)
            } catch {
                print("Failed to cache avatar image: \(error.localizedDescription)")
            }
            
            // Create INImage from the downloaded data
            let inImage = INImage(imageData: data) // Create directly
            completion(inImage)
        }.resume()
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
        
        guard let avatarIdentifier = metadata["avatar"] as? String else {
            throw ParseNotificationPayloadError.missingAvatarUrl("The notification has no avatar.")
        }
        
        let avatarUrl = getAttachmentUrl(for: avatarIdentifier)
        fetchAvatarImage(from: avatarUrl) { [weak self] inImage in
            guard let self = self else { return }
            
            let handle = INPersonHandle(value: "\(metadata["user_id"] ?? "")", type: .unknown)
            let sender = INPerson(
                personHandle: handle,
                nameComponents: nil,
                displayName: content.title,
                image: inImage,
                contactIdentifier: nil,
                customIdentifier: nil
            )
            
            if content.categoryIdentifier == "messaging.callStart" {
                let intent = self.createCallIntent(with: sender)
                self.donateInteraction(for: intent)
                let updatedContent = try? request.content.updating(from: intent)
                self.contentHandler?(updatedContent ?? content)
            } else {
                let intent = self.createMessageIntent(with: sender, metadata: metadata, body: content.body)
                self.donateInteraction(for: intent)
                let updatedContent = try? request.content.updating(from: intent)
                self.contentHandler?(updatedContent ?? content)
            }
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
        
        guard let remoteUrl = URL(string: attachmentUrl) else {
            print("Invalid URL for attachment: \(attachmentUrl)")
            return
        }
        
        // Define a cache location based on the identifier
        let tempDirectory = FileManager.default.temporaryDirectory
        let cachedFileUrl = tempDirectory.appendingPathComponent(identifier)
        
        if FileManager.default.fileExists(atPath: cachedFileUrl.path) {
            // Use cached file
            attachLocalMedia(to: content, from: cachedFileUrl, withIdentifier: identifier)
        } else {
            // Download and cache the file
            let session = URLSession(configuration: .default)
            session.downloadTask(with: remoteUrl) { [weak content] localUrl, response, error in
                guard let content = content else { return }
                
                if let error = error {
                    print("Failed to download media: \(error.localizedDescription)")
                    self.contentHandler?(content)
                    return
                }
                
                guard let localUrl = localUrl else {
                    print("No local file URL after download")
                    self.contentHandler?(content)
                    return
                }
                
                do {
                    // Move the downloaded file to the cache
                    try FileManager.default.moveItem(at: localUrl, to: cachedFileUrl)
                    self.attachLocalMedia(to: content, from: cachedFileUrl, withIdentifier: identifier)
                } catch {
                    print("Failed to cache media file: \(error.localizedDescription)")
                    self.contentHandler?(content)
                }
            }.resume()
        }
    }

    private func attachLocalMedia(to content: UNMutableNotificationContent, from localUrl: URL, withIdentifier identifier: String) {
        if let attachment = try? UNNotificationAttachment(identifier: identifier, url: localUrl) {
            content.attachments = [attachment]
        } else {
            print("Failed to create attachment from cached file: \(localUrl.path)")
        }
        self.contentHandler?(content)
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
