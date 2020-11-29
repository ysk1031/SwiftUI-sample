//
//  HomeView.swift
//  GitHubAPIClient
//
//  Created by Yusuke Aono on 2020/11/28.
//

import SwiftUI

struct HomeView: View {
    @State private var cardViewInputs: [CardView.Input] = []
    @State private var text: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(cardViewInputs) { input in
                    Button(action: {
                    }) {
                        CardView(input: input)
                    }
                }
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HStack {
                TextField(
                    "検索キーワードを入力",
                    text: $text
                ) { _ in
                } onCommit: {
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.asciiCapable)
                .frame(width: UIScreen.main.bounds.width - 40)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
