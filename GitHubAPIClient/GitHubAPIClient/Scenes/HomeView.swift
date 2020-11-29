//
//  HomeView.swift
//  GitHubAPIClient
//
//  Created by Yusuke Aono on 2020/11/28.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel(apiService: APIService())
    @State private var text: String = ""
    
    var body: some View {
        if viewModel.isLoading {
            Text("読み込み中...")
                .font(.headline)
                .foregroundColor(.gray)
                .offset(x: 0, y: -200)
                .navigationBarTitle("", displayMode: .inline)
        } else {
            NavigationView {
                ScrollView(.vertical, showsIndicators: true) {
                    ForEach(viewModel.cardViewInputs) { input in
                        Button(action: {
                            viewModel.apply(inputs: .tappedCardView(urlString: input.url))
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
                        viewModel.apply(inputs: .onCommit(text: text))
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.asciiCapable)
                    .frame(width: UIScreen.main.bounds.width - 40)
                })
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
