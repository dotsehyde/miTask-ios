//
//  MiTaskWidget.swift
//  MiTaskWidget
//
//  Created by Benjamin on 06/09/2022.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct MiTaskWidgetEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    var body: some View {
        GeometryReader { g in
            ZStack {
                backgroundGradient
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                Image("logo")
                    .resizable()
                    .frame(width: widgetFamily != .systemSmall ? 56 : 36, height: widgetFamily != .systemSmall ? 56 : 36)
                    .offset(x: (g.size.width / 2) - 20,
                            y: (g.size.height / -2) + 20)
                    .padding(.top, widgetFamily != .systemSmall ? 32 : 12)
                    .padding(.trailing, widgetFamily != .systemSmall ? 32 : 12)

                HStack {
                    Text("Just Do Task")
                        .foregroundColor(.white)
                        .font(.system(.footnote, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                        .blendMode(.overlay))
                        .clipShape(Capsule())
                    if widgetFamily != .systemSmall {
                        Spacer()
                    }

                }
                    .padding()
                    .offset(y: (g.size.height / 2) - 24)
            }
        }
    }
}

@main
struct MiTaskWidget: Widget {
    let kind: String = "MiTaskWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MiTaskWidgetEntryView(entry: entry)
        }
            .configurationDisplayName("MiTask")
            .description("Write down your daily tasks.")
    }
}

struct MiTaskWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MiTaskWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            MiTaskWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            MiTaskWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
