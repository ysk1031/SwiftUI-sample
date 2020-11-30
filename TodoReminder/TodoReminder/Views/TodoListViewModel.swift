//
//  TodoListViewModel.swift
//  TodoReminder
//
//  Created by Yusuke Aono on 2020/11/30.
//

import Foundation
import Combine

final class TodoListViewModel: ObservableObject {
    enum Inputs {
        case onAppear
        case onDismissAddTodo
        case openFromWidget(url: URL)
    }
    
    @Published var todoList: [TodoListItem] = []
    @Published var activeTodoID: UUID?
    
    private let todoStore = TodoListStore()
    
    func apply(inputs: Inputs) {
        switch inputs {
        case .onAppear:
            updateTodo()
        case .onDismissAddTodo:
            updateTodo()
        case .openFromWidget(let url):
            if let selectedId = getWidgetTodoItemID(from: url) {
                activeTodoID = selectedId
            }
        }
    }
    
    func getWidgetTodoItemID(from url: URL) -> UUID? {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
              urlComponents.scheme == "todolist",
              urlComponents.host == "detail",
              urlComponents.queryItems?.first?.name == "id",
              let idValue = urlComponents.queryItems?.first?.value else {
            return nil
        }
        return UUID(uuidString: idValue)
    }
    
    private func updateTodo() {
        do {
            let list = try todoStore.fetchAll()
            print("list count is \(list.count)")
            todoList = list
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
