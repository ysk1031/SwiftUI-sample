//
//  CardView.swift
//  GitHubAPIClient
//
//  Created by Yusuke Aono on 2020/11/28.
//

import SwiftUI
import UIKit

struct CardView: View {
    struct Input: Identifiable {
        let id: UUID = UUID()
        let iconImage: UIImage
        let title: String
        let language: String?
        let star: Int
        let description: String?
        let url: String
    }
    
    let input: Input
    
    var body: some View {
        LazyVStack(
            alignment: .leading,
            spacing: 8.0
        ) {
            Image(uiImage: input.iconImage)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .shadow(color: .gray, radius: 2)

            Text(input.title)
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.bold)

            LazyHStack {
                Text(input.language ?? "")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
                LazyHStack(spacing: 4) {
                    Image(systemName: "star")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                    Text(input.star.description)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }

            Text(input.description ?? "")
                .foregroundColor(.black)
                .lineLimit(nil)

        }
        .padding(24)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray, lineWidth: 1)
        )
        .frame(minWidth: 140, minHeight: 180)
        .padding(16)
    }
}

class CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(
            input: CardView.Input(
                iconImage: UIImage(systemName: "bookmark")!,
                title: "title",
                language: "lang",
                star: 100,
                description: "desc",
                url: "https://google.co.jp"
            )
        )
        .previewLayout(.sizeThatFits)
    }
}
