//
//  TopHeadlinesRequest.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import Moya

// MARK: - TopHeadlineRequest
struct TopHeadlineRequest: NewsRequest {
    
    typealias Response = TopHeadlineResponse
    
    var path: String {
        return "/top-headlines"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        let parameters: [String: Any] = [
            "country": country
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    let country: String
}

// MARK: - TopHeadlineRequest DataResponse
struct TopHeadlineResponse: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    struct Article: Codable {
        let source: Source
        let author: String?
        let title: String
        let articleDescription: String?
        let url: String
        let urlToImage: String?
        let publishedAt: String
        let content: String?

        enum CodingKeys: String, CodingKey {
            case source, author, title
            case articleDescription = "description"
            case url, urlToImage, publishedAt, content
        }
    }

    struct Source: Codable {
        let id: String?
        let name: String
    }
}

