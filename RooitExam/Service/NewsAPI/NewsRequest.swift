//
//  NewsRequest.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import Moya

// MARK: - NewsRequest
protocol NewsRequest: TargetType {
    associatedtype Response: Decodable
}

// MARK: - Request default implementation
extension NewsRequest {
    
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2")!
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json",
        ]
    }
}
