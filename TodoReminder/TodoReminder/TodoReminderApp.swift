//
//  TodoReminderApp.swift
//  TodoReminder
//
//  Created by Yusuke Aono on 2020/11/29.
//

import SwiftUI
import WidgetKit

@main
struct TodoReminderApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .onChange(of: scenePhase, perform: { newScenePhase in
                    if newScenePhase == .active {
                        WidgetCenter.shared.reloadTimelines(ofKind: "TodoReminderWidget")
                    }
                })
        }
    }
}
