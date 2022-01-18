//
//  NewsAPI.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import Moya
import Alamofire

// MARK: - News API
class NewsAPI {
    
    // MARK: Singleton
    static let shared = NewsAPI()
    
    // MARK: Configurer
    func configure(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: Initializer
    init() {}
    
    // MARK: - Properties
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return Session.init(configuration: configuration)
    }()
    
    private(set) var apiKey: String?
    
    // MARK: Setting Methods
    private func send<Req: NewsRequest>(
        request: Req,
        completion: @escaping ((Result<Req.Response, Error>) -> Void))
    {
        let provider = MoyaProvider<Req>(endpointClosure: endpointMapping,
                                         callbackQueue: .main,
                                         session: session)
        provider.request(request) { result in
            switch result {
            case .success(let response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    let decoded = try JSONDecoder().decode(Req.Response.self, from: response.data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func endpointMapping<Req: NewsRequest>(_ request: Req) -> Endpoint {
        var httpHeaderFields = request.headers
        if let apiKey = apiKey {
            httpHeaderFields?["X-Api-Key"] = apiKey
        }
        return Endpoint(
            url: URL(target: request).absoluteString,
            sampleResponseClosure: { .networkResponse(200, request.sampleData) },
            method: request.method,
            task: request.task,
            httpHeaderFields: httpHeaderFields
        )
    }
    
    
}

// MARK: - NewsAPI facade
extension NewsAPI {
    
    typealias ResultHandler<D: Decodable> = (Result<D, Error>) -> Void
    
    func getTopHeadlines(country: String,
                         resultHandler: @escaping ResultHandler<[TopHeadlineResponse.Article]>) {
        let request = TopHeadlineRequest(country: country)
        send(request: request) { result in
            switch result {
            case .success(let data):
                resultHandler(.success(data.articles))
            case .failure(let error):
                resultHandler(.failure(error))
            }
        }
    }
}

