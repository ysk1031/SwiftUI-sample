//
//  Owner.swift
//  GitHubAPIClient
//
//  Created by Yusuke Aono on 2020/11/29.
//

import Foundation

struct Owner: Decodable, Hashable, Identifiable {
    let id: Int
    let avatarUrl: String
}
