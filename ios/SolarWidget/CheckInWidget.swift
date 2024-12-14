//
//  SolarWidget.swift
//  SolarWidget
//
//  Created by LittleSheep on 2024/12/14.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), user: nil, checkIn: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let prefs = UserDefaults(suiteName: "group.solsynth.solian")
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let userRaw = prefs?.string(forKey: "user")
        var user: SolarUser?
        if let userRaw = userRaw {
            user = try! jsonDecoder.decode(SolarUser.self, from: userRaw.data(using: .utf8)!)
        }
        
        let checkInRaw = prefs?.string(forKey: "today_check_in")
        var checkIn: SolarCheckInRecord?
        if let checkInRaw = checkInRaw {
            checkIn = try! jsonDecoder.decode(SolarCheckInRecord.self, from: checkInRaw.data(using: .utf8)!)
        }
        
        let entry = SimpleEntry(
            date: Date(),
            user: user,
            checkIn: checkIn
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

struct SimpleEntry: TimelineEntry {
    let date: Date
    let user: SolarUser?
    let checkIn: SolarCheckInRecord?
}

struct SolarWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading) {
            if let user = entry.user {
                Text("User")
                Text("\(user.name)")
            }
        }
    }
}

struct CheckInWidget: Widget {
    let kind: String = "SolarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                SolarWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SolarWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Solar Overview")
        .description("Get Instant Insights on your home screen")
    }
}

#Preview(as: .systemSmall) {
    CheckInWidget()
} timeline: {
    SimpleEntry(date: .now, user: nil, checkIn: nil)
    SimpleEntry(
        date: .now,
        user: SolarUser(id: 1, name: "demo", nick: "Deemo"),
        checkIn: SolarCheckInRecord(id: 1, resultTier: 1, createdAt: Date.now)
    )
}
