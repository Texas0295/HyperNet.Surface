//
//  SolarWidget.swift
//  SolarWidget
//
//  Created by LittleSheep on 2024/12/14.
//

import WidgetKit
import SwiftUI

struct CheckInProvider: TimelineProvider {
    func placeholder(in context: Context) -> CheckInEntry {
        CheckInEntry(date: Date(), user: nil, checkIn: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (CheckInEntry) -> ()) {
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
        
        let checkInRaw = prefs?.string(forKey: "pas_check_in_record")
        var checkIn: SolarCheckInRecord?
        if let checkInRaw = checkInRaw {
            checkIn = try! jsonDecoder.decode(SolarCheckInRecord.self, from: checkInRaw.data(using: .utf8)!)
            if checkIn != nil && Calendar.current.isDate(checkIn!.createdAt, inSameDayAs: Date()) {
                checkIn = nil
            }
        }
        
        let entry = CheckInEntry(
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

struct CheckInEntry: TimelineEntry {
    let date: Date
    let user: SolarUser?
    let checkIn: SolarCheckInRecord?
}

struct CheckInWidgetEntryView : View {
    var entry: CheckInProvider.Entry
    
    private let resultTierSymbols: [String] = ["大凶", "凶", "中平", "吉", "大吉"]
    
    func checkIn() -> Void {}
    
    func seeDetail() -> Void {}

    var body: some View {
        VStack(alignment: .leading) {
            if let checkIn = entry.checkIn {
                VStack(alignment: .leading) {
                    Text(resultTierSymbols[checkIn.resultTier]).font(.system(size: 27, weight: .bold))
                    Text("+\(checkIn.resultExperience) EXP").font(.system(size: 15, design: .monospaced))
                }.padding(.horizontal, 4)
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(
                            checkIn.createdAt,
                            format: .dateTime.weekday()
                        ).font(.system(size: 13))
                        Text(
                            checkIn.createdAt,
                            format: .dateTime.day().month()
                        ).font(.system(size: 13))
                    }.padding(.leading, 4)
                    
                    Button("See Detail", systemImage: "arrow.right", action: seeDetail)
                        .labelStyle(.iconOnly)
                        .buttonBorderShape(.circle)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.frame(alignment: .bottom)
            } else {
                VStack(alignment: .leading) {
                    Text("Check In").font(.system(size: 19, weight: .bold))
                    Text("You haven't check in today").font(.system(size: 15))
                }.padding(.horizontal, 4)
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    Button("Check In", systemImage: "checkmark", action: checkIn).labelStyle(.iconOnly).buttonBorderShape(.circle).frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }.padding(8).widgetURL(URL(string: "https://sn.solsynth.dev"))
    }
}

struct CheckInWidget: Widget {
    let kind: String = "SolarCheckInWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CheckInProvider()) { entry in
            if #available(iOS 17.0, *) {
                CheckInWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                CheckInWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Check In")
        .description("View your today's fortune on your home screen")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    CheckInWidget()
} timeline: {
    CheckInEntry(date: .now, user: nil, checkIn: nil)
    CheckInEntry(
        date: .now,
        user: SolarUser(id: 1, name: "demo", nick: "Deemo"),
        checkIn: SolarCheckInRecord(id: 1, resultTier: 1, resultExperience: 100, createdAt: Date.now)
    )
}
