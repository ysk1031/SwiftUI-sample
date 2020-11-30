//
//  ContentView.swift
//  TodoReminder
//
//  Created by Yusuke Aono on 2020/11/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onOpenURL { url in
                print(url)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
