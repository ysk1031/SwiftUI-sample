//
//  TodoReminderWidget.swift
//  TodoReminderWidget
//
//  Created by Yusuke Aono on 2020/11/29.
//

import WidgetKit
import SwiftUI

struct TodoReminderWidgetEntryView : View, TodoReminderWidgetType {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(makePriorityColor(priority: entry.priority))
                .clipShape(ContainerRelativeShape())
                .overlay(Text(entry.title).font(.title).foregroundColor(.white))
            VStack(alignment: .trailing) {
                Text(entry.date, style: .date).font(.caption)
                Text(entry.date, style: .time).font(.caption)
            }
        }
        .padding(8)
        .widgetURL(makeURLScheme(id: entry.id))
    }
}

@main
struct TodoReminderWidget: Widget {
    let kind: String = "TodoReminderWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TodoReminderWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Todo Reminder")
        .description("直近のTodoListをお知らせします")
        .supportedFamilies([.systemSmall])
    }
}

struct TodoReminderWidget_Previews: PreviewProvider {
    static var previews: some View {
        let dummyEntry = RecentTodoEntry(date: Date(), title: "dummy title", priority: .low, id: UUID())
        return TodoReminderWidgetEntryView(entry: dummyEntry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
