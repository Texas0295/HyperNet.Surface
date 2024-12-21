//
//  RandomPostWidget.swift
//  Runner
//
//  Created by LittleSheep on 2024/12/14.
//

import SwiftUI
import WidgetKit
import Kingfisher

struct RandomPostProvider: TimelineProvider {
    func placeholder(in context: Context) -> RandomPostEntry {
        RandomPostEntry(date: Date(), user: nil, randomPost: nil, family: .systemMedium)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (RandomPostEntry) -> ()) {
        let prefs = UserDefaults(suiteName: "group.solsynth.solian")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let userRaw = prefs?.string(forKey: "user")
        var user: SolarUser?
        if let userRaw = userRaw {
            user = try! jsonDecoder.decode(SolarUser.self, from: userRaw.data(using: .utf8)!)
        }
        
        let randomPostRaw = prefs?.string(forKey: "int_random_post")
        var randomPost: SolarPost?
        if let randomPostRaw = randomPostRaw {
            randomPost = try! jsonDecoder.decode(SolarPost.self, from: randomPostRaw.data(using: .utf8)!)
        }
        
        
        let entry = RandomPostEntry(
            date: Date(),
            user: user,
            randomPost: randomPost,
            family: context.family
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct RandomPostEntry: TimelineEntry {
    let date: Date
    let user: SolarUser?
    let randomPost: SolarPost?
    
    let family: WidgetFamily
}

struct RandomPostWidgetEntryView : View {
    var entry: RandomPostProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let randomPost = entry.randomPost {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        if let avatar = randomPost.publisher.avatar {
                            let avatarUrl = getAttachmentUrl(for: avatar)
                            let size: CGFloat = 28
                            let scaleProcessor = ResizingImageProcessor(referenceSize: CGSize(width: size, height: size), mode: .aspectFill)
                            
                            KFImage.url(URL(string: avatarUrl))
                                .resizable()
                                .setProcessor(scaleProcessor)
                                .fade(duration: 0.25)
                                .placeholder{
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                }
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size, height: size)
                                .cornerRadius(size / 2)
                            
                                .frame(width: size, height: size, alignment: .center)
                        }
                        
                        Text(randomPost.publisher.nick)
                            .font(.system(size: 15))
                            .opacity(0.9)
                        
                        Text("@\(randomPost.publisher.name)")
                            .font(.system(size: 13, design: .monospaced))
                            .opacity(0.9)
                        
                        Spacer()
                    }.frame(maxWidth: .infinity).padding(.bottom, 12)
                    
                    if randomPost.body.title != nil || randomPost.body.description != nil {
                        VStack(alignment: .leading) {
                            if let title = randomPost.body.title {
                                Text(title)
                                    .font(.system(size: 17))
                            }
                            if let description = randomPost.body.description {
                                Text(description)
                                    .font(.system(size: 15))
                            }
                        }.padding(.bottom, 8)
                    }
                    
                    if let content = randomPost.body.content {
                        if (randomPost.body.title == nil && randomPost.body.description == nil) || entry.family == .systemLarge || entry.family == .systemExtraLarge {
                            Text(
                                (entry.family == .systemLarge || entry.family == .systemExtraLarge) ? content : content.replacingOccurrences(of: "\n", with: " ")
                            )
                            .font(.system(size: 15))
                        } else {
                            Text("\(Image(systemName: "plus")) total \(content.count) characters")
                                .font(.system(size: 11, design: .monospaced))
                                .opacity(0.75)
                                .padding(.top, 1)
                        }
                    }
                    
                    if let attachment = randomPost.body.attachments {
                        if attachment.count == 1 {
                            Text("\(Image(systemName: "document.fill")) \(attachment.count) attachment")
                                .font(.system(size: 11, design: .monospaced))
                                .opacity(0.75)
                                .padding(.top, 2)
                        } else if attachment.count > 1 {
                            Text("\(Image(systemName: "document.fill")) \(attachment.count) attachments")
                                .font(.system(size: 11, design: .monospaced))
                                .opacity(0.75)
                                .padding(.top, 2)
                        }
                    }
                    
                    Spacer()
                    
                    Text(randomPost.publishedAt!, format: .dateTime)
                        .font(.system(size: 11))
                    Text("#\(randomPost.id)")
                        .font(.system(size: 9))
                }.widgetURL(URL(string: "https://sn.solsynth.dev/posts/\(randomPost.id)"))
            } else {
                VStack(alignment: .center) {
                    Text("No Recommendations").font(.system(size: 19, weight: .bold))
                    Text("Open the app to load some random post")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                }.frame(alignment: .center)
            }
        }.padding(8).frame(maxWidth: .infinity)
    }
}

struct RandomPostWidget: Widget {
    let kind: String = "SolarRandomPostWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: RandomPostProvider()) { entry in
            if #available(iOS 17.0, *) {
                RandomPostWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                RandomPostWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Random Post")
        .description("View the random post on the Solar Network")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
    }
}

#Preview(as: .systemSmall) {
    RandomPostWidget()
} timeline: {
    RandomPostEntry(date: Date.now, user: nil, randomPost: nil, family: .systemLarge)
    RandomPostEntry(
        date: .now,
        user: SolarUser(id: 1, name: "demo", nick: "Deemo"),
        randomPost: SolarPost(
            id: 1,
            body: SolarPostBody(
                content: "Hello, World",
                title: nil,
                description: nil,
                attachments: ["zb2hiUEmYcnpHfVN"]
            ),
            publisher: SolarPublisher(
                id: 1,
                name: "demo",
                nick: "Deemo",
                description: nil,
                avatar: "IZxCFkJUPKRijFCx",
                banner: nil,
                createdAt: .now,
                updatedAt: .now
            ),
            publisherId: 1,
            createdAt: .now,
            updatedAt: .now,
            editedAt: nil,
            publishedAt: .now
        ),
        family: .systemSmall
    )
    RandomPostEntry(
        date: .now,
        user: SolarUser(id: 1, name: "demo", nick: "Deemo"),
        randomPost: SolarPost(
            id: 1,
            body: SolarPostBody(
                content: "Hello, World\nOh wow",
                title: "Title",
                description: "Description",
                attachments: ["zb2hiUEmYcnpHfVN"]
            ),
            publisher: SolarPublisher(
                id: 1,
                name: "demo",
                nick: "Deemo",
                description: nil,
                avatar: "IZxCFkJUPKRijFCx",
                banner: nil,
                createdAt: .now,
                updatedAt: .now
            ),
            publisherId: 1,
            createdAt: .now,
            updatedAt: .now,
            editedAt: nil,
            publishedAt: .now
        ),
        family: .systemLarge
    )
}
