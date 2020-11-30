//
//  Provider.swift
//  TodoReminder
//
//  Created by Yusuke Aono on 2020/11/30.
//

import SwiftUI
import WidgetKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RecentTodoEntry {
        RecentTodoEntry(date: Date(), title: "dummy title", priority: .high, id: UUID())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (RecentTodoEntry) -> Void) {
        let dummyEntry = RecentTodoEntry(date: Date(), title: "dummy title", priority: .high, id: UUID())
        let emptyEntry = RecentTodoEntry(date: Date(), title: "Todoはありません", priority: .low, id: UUID())
        if context.isPreview {
            completion(dummyEntry)
        } else {
            do {
                let store = TodoListStore()
                let todoLists = try store.fetchTodayItems()
                let entries = todoLists.map { todoList in
                    RecentTodoEntry(todoItem: todoList)
                }
                guard let first = entries.first else {
                    completion(emptyEntry)
                    return
                }
                completion(first)
            } catch let error {
                print(error.localizedDescription)
                completion(dummyEntry)
            }
        }
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<RecentTodoEntry>) -> Void) {
        let emptyEntry = RecentTodoEntry(date: Date(), title: "Todoはありません", priority: .low, id: UUID())
        do {
            let store = TodoListStore()
            let todoLists = try store.fetchTodayItems()
            var entries = todoLists.map { todoList in
                RecentTodoEntry(todoItem: todoList)
            }
            if entries.isEmpty {
                entries.append(emptyEntry)
            }
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        } catch let error {
            print(error.localizedDescription)
            let timeline = Timeline(entries: [emptyEntry], policy: .atEnd)
            completion(timeline)
        }
    }
}
