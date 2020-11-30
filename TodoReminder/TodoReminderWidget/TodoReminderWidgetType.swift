//
//  TodoReminderWidgetType.swift
//  TodoReminder
//
//  Created by Yusuke Aono on 2020/11/30.
//

import SwiftUI

protocol TodoReminderWidgetType {
    func makePriorityColor(priority: TodoPriority) -> Color
    func makeURLScheme(id: UUID) -> URL?
}

extension TodoReminderWidgetType where Self: View {
    func makePriorityColor(priority: TodoPriority) -> Color {
        switch priority {
        case .high:
            return .red
        case .medium:
            return .yellow
        case .low:
            return .green
        }
    }
    
    func makeURLScheme(id: UUID) -> URL? {
        guard let url = URL(string: "todolist://detail") else {
            return nil
        }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "id", value: id.uuidString)]
        return urlComponents?.url
    }
}
