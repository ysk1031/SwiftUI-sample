//
//  Repository.swift
//  GitHubAPIClient
//
//  Created by Yusuke Aono on 2020/11/29.
//

import Foundation

struct SearchRepositoryResponse: Decodable {
    let items: [Repository]
}

struct Repository: Decodable, Hashable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let stargazersCount: Int
    let language: String?
    let htmlUrl: String
    let owner: Owner
}
