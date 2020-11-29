//
//  SearchRepositoryRequest.swift
//  GitHubAPIClient
//
//  Created by Yusuke Aono on 2020/11/29.
//

import Foundation

struct SearchRepositoryRequest: APIRequestType {
    typealias Response = SearchRepositoryResponse
    
    var path: String {
        return "/search/repositories"
    }
    var queryItems: [URLQueryItem]? {
        return [
            .init(name: "q", value: query),
            .init(name: "order", value: "desc")
        ]
    }
    
    private let query: String
    
    init(query: String) {
        self.query = query
    }
}
