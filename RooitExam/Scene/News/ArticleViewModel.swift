//
//  ArticleViewModel.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import Foundation

class ArticleViewModel {
    
    let content: String?
    let imageURL: URL?
    
    init(article: Article) {
        self.content = article.content
        self.imageURL = URL(string: article.urlToImage ?? "")
    }
}
