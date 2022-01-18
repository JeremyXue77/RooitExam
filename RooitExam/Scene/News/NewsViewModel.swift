//
//  NewsViewModel.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import Foundation
import RxSwift

class NewsStore {
    
    // MARK: Properties
    private let database: Database<Article> = .init()
    private let newAPI: NewsAPI = .shared
    let articleSubject = PublishSubject<[Article]>()
    
    // MARK: Methods
    func updateNews() {
        newAPI.getTopHeadlines(country: "us") { [weak self](result) in
            switch result {
            case .success(let articles):
                try? self?.database.save(items: articles)
            case .failure(let error):
                self?.articleSubject.onError(error)
            }
        }
    }
    
    func observeDatabase() {
        database.onChanged = { [weak self](items) in
            self?.articleSubject.onNext(items)
        }
    }
}
