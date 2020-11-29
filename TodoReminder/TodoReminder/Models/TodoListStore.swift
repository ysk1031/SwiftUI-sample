//
//  TodoListStore.swift
//  TodoReminder
//
//  Created by Yusuke Aono on 2020/11/29.
//

import Foundation
import CoreData

struct TodoListItem: Identifiable {
    var startDate: Date
    var note: String
    var priority: TodoPriority
    var title: String
    var id: UUID = UUID()
}

enum TodoPriority: Int {
    case low = 0
    case medium
    case high
    
    var name: String {
        switch self {
        case .high:
            return "高"
        case .medium:
            return "中"
        case .low:
            return "低"
        }
    }
}

extension TodoList {
    func convert() -> TodoListItem? {
        guard let startDate = startDate,
              let note = note,
              let priority = TodoPriority(rawValue: Int(priority)),
              let title = title,
              let id = id else {
            return nil
        }
        return TodoListItem(startDate: startDate, note: note, priority: priority, title: title, id: id)
    }
}

final class TodoListStore {
    typealias Entity = TodoList
    
    static var containerName: String = "Todo"
    static var entityName: String = "TodoList"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: TodoListStore.containerName)
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func fetchAll() throws -> [TodoListItem] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: TodoListStore.entityName)
        do {
            guard let result = try persistentContainer.viewContext.fetch(fetchRequest) as? [Entity] else {
                throw CoreDataStoreError.failureFetch
            }
            let todoList: [TodoListItem] = result.compactMap { $0.convert() }
            return todoList
        } catch let error {
            throw error
        }
    }
}

enum CoreDataStoreError: Error {
    case failureFetch
}
