//
//  RooitExamNewsAPITests.swift
//  RooitExamNewsAPITests
//
//  Created by Jeremy Xue on 2022/1/18.
//

import XCTest
@testable import RooitExam

class RooitExamNewsAPITests: XCTestCase {
    

    func testNewsAPIConfiguration() {
        let apiKey = NEWS_API_KEY
        NewsAPI.shared.configure(apiKey: apiKey)
        XCTAssertEqual(NewsAPI.shared.apiKey, apiKey)
    }
    
    func testGetTopHeadlines() {
        let apiKey = NEWS_API_KEY
        NewsAPI.shared.configure(apiKey: apiKey)
        let promise = expectation(description: "Got top headlines articles")
        var _articles: [Article]?
        var _error: Error?
        NewsAPI.shared.getTopHeadlines(country: "us") { result in
            switch result {
            case .success(let articles):
                _articles = articles
            case .failure(let error):
                _error = error
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
        XCTAssertNotNil(_articles)
        XCTAssertNil(_error, _error?.localizedDescription ?? "Something error")
    }
}
