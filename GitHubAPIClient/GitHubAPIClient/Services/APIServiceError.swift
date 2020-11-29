//
//  APIServiceError.swift
//  GitHubAPIClient
//
//  Created by Yusuke Aono on 2020/11/29.
//

import Foundation

enum APIServiceError: Error {
    case invalidURL
    case responseError
    case parseError(Error)
}
