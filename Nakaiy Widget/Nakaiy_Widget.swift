//
//  Nakaiy_Widget.swift
//  Nakaiy Widget
//
//  Created by Simon Shareef on 13/06/2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> NakaiyEntry {
        NakaiyEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (NakaiyEntry) -> ()) {
        let entry = NakaiyEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [NakaiyEntry] = []

        // Generate a timeline consisting of seven entries an hour apart, starting from the current date.
        let currentDate = Date()
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate)!
            let startofDate = Calendar.current.startOfDay(for: entryDate)
            let entry = NakaiyEntry(date: startofDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}



struct WidgetView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        switch widgetFamily {
            case .systemMedium:
            MediumView(entry: entry)
            case .systemSmall:
            SmallView(entry: entry)
            default:
            Text("Not Implemented")
        }
    }
}

struct Nakaiy_Widget: Widget {
    let kind: String = "Nakaiy_Widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("Nakaiy Nevi")
        .description("Today's Nakaiy information.")
    }
}

struct Nakaiy_Widget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(entry: NakaiyEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
