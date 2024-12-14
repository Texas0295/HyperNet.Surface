//
//  FeaturedPostWidget.swift
//  Runner
//
//  Created by LittleSheep on 2024/12/14.
//

import SwiftUI
import WidgetKit

struct FeaturedPostProvider: TimelineProvider {
    func placeholder(in context: Context) -> FeaturedPostEntry {
        FeaturedPostEntry(date: Date(), user: nil, featuredPost: nil, family: .systemMedium)
    }

    func getSnapshot(in context: Context, completion: @escaping (FeaturedPostEntry) -> ()) {
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
        
        let featuredPostRaw = prefs?.string(forKey: "post_featured")
        var featuredPosts: [SolarPost]?
        if let featuredPostRaw = featuredPostRaw {
            featuredPosts = try! jsonDecoder.decode([SolarPost].self, from: featuredPostRaw.data(using: .utf8)!)
        }
        
        let entry = FeaturedPostEntry(
            date: Date(),
            user: user,
            featuredPost: featuredPosts?.first,
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

struct FeaturedPostEntry: TimelineEntry {
    let date: Date
    let user: SolarUser?
    let featuredPost: SolarPost?
    
    let family: WidgetFamily
}

struct FeaturedPostWidgetEntryView : View {
    var entry: FeaturedPostProvider.Entry
    
    private let resultTierSymbols: [String] = ["大凶", "凶", "中平", "大吉", "吉"]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let featuredPost = entry.featuredPost {
                HStack(alignment: .center) {
                    if let avatar = featuredPost.publisher.avatar {
                        let avatarUrl = getAttachmentUrl(for: avatar)
                        let size: CGFloat = 24
                        
                        AsyncImage(url: URL(string: avatarUrl)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: size, height: size)
                                .cornerRadius(size / 2)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 4)
                                        .frame(width: size, height: size)
                                )
                                .shadow(radius: 10)
                                .frame(width: 24, height: 24, alignment: .center)
                        } placeholder: {
                            ProgressView().frame(width: 24, height: 24, alignment: .center)
                        }
                    }
                    
                    Text("@\(featuredPost.publisher.name)")
                        .font(.system(size: 13, design: .monospaced))
                        .opacity(0.9)
                    
                    Spacer()
                }.frame(maxWidth: .infinity).padding(.bottom, 12)
                
                if featuredPost.body.title != nil || featuredPost.body.description != nil {
                    VStack(alignment: .leading) {
                        if let title = featuredPost.body.title {
                            Text(title)
                                .font(.system(size: 17))
                        }
                        if let description = featuredPost.body.description {
                            Text(description)
                                .font(.system(size: 15))
                        }
                    }.padding(.bottom, 8)
                }
                
                if let content = featuredPost.body.content {
                    if (featuredPost.body.title == nil && featuredPost.body.description == nil) || entry.family == .systemLarge || entry.family == .systemExtraLarge {
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
                
                if let attachment = featuredPost.body.attachments {
                    if attachment.count == 1 {
                        Text("\(Image(systemName: "document.fill")) \(attachment.count) attachment")
                            .font(.system(size: 11, design: .monospaced))
                            .opacity(0.75)
                            .padding(.top, 1)
                    } else if attachment.count > 1 {
                        Text("\(Image(systemName: "document.fill")) \(attachment.count) attachments")
                            .font(.system(size: 11, design: .monospaced))
                            .opacity(0.75)
                            .padding(.top, 1)
                    }
                }
                
                Spacer()
                
                Text(featuredPost.publishedAt!, format: .dateTime)
                    .font(.system(size: 11))
                Text("Solar Network Featured Posts")
                    .font(.system(size: 9))
            } else {
                VStack(alignment: .center) {
                    Text("No Recommendations").font(.system(size: 19, weight: .bold))
                    Text("Click the widget to open the app to load featured posts")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                }.frame(alignment: .center)
            }
        }.padding(8).frame(maxWidth: .infinity)
    }
}

struct FeaturedPostWidget: Widget {
    let kind: String = "SolarFeaturedPostWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: FeaturedPostProvider()) { entry in
            if #available(iOS 17.0, *) {
                FeaturedPostWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                FeaturedPostWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Featured Posts")
        .description("View the featured posts on the Solar Network")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge, .systemExtraLarge])
    }
}

#Preview(as: .systemSmall) {
    FeaturedPostWidget()
} timeline: {
    FeaturedPostEntry(date: Date.now, user: nil, featuredPost: nil, family: .systemLarge)
    FeaturedPostEntry(
        date: .now,
        user: SolarUser(id: 1, name: "demo", nick: "Deemo"),
        featuredPost: SolarPost(
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
    FeaturedPostEntry(
        date: .now,
        user: SolarUser(id: 1, name: "demo", nick: "Deemo"),
        featuredPost: SolarPost(
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
