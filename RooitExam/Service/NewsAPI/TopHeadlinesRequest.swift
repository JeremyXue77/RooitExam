//
//  TopHeadlinesRequest.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import Moya
import RealmSwift

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
}

class Article: Object, Codable {
    @Persisted var source: Source?
    @Persisted var author: String?
    @Persisted var title: String
    @Persisted var articleDescription: String?
    @Persisted var url: String
    @Persisted var urlToImage: String?
    @Persisted var publishedAt: String
    @Persisted var content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

class Source: Object, Codable {
    @Persisted var id: String?
    @Persisted var name: String
}
