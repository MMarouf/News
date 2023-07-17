//
//  Headline+Mock.swift
//  NewsTests
//
//  Created by Mohamed Marouf on 17/07/2023.
//

@testable import News
import Foundation

extension Headline {
    static func mock(status: String = "test", totalResults: Int = 0, articles: [Article] = [.mock()]) -> Self {
        .init(
            status: status,
            totalResults: totalResults,
            articles: articles
        )
    }
}

extension Article {
    static func mock(
        source: Source = .mock(),
        author: String? = nil,
        title: String = "",
        description: String? = nil,
        url: String = "",
        urlToImage: String? = nil,
        publishedAt: String? = nil,
        content: String? = nil
    ) -> Self {
        .init(source: source, author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content)
    }
}

extension Source {
    static func mock(id: String? = nil, name: String? = nil) -> Self {
        .init(id: id, name: name)
    }
}

