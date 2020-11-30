//
//  RecentTodoEntry.swift
//  TodoReminderWidgetExtension
//
//  Created by Yusuke Aono on 2020/11/30.
//

import SwiftUI
import WidgetKit

struct RecentTodoEntry: TimelineEntry {
    let date: Date
    let title: String
    let priority: TodoPriority
    let id: UUID
    
    init(date: Date, title: String, priority: TodoPriority, id: UUID) {
        self.date = date
        self.title = title
        self.priority = priority
        self.id = id
    }
    
    init(todoItem: TodoListItem) {
        self.date = todoItem.startDate
        self.title = todoItem.title
        self.priority = todoItem.priority
        self.id = todoItem.id
    }
}
