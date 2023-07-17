//
//  Headline.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Headline: Decodable, Equatable {
    static func == (lhs: Headline, rhs: Headline) -> Bool {
        lhs.id == rhs.id
    }
    var id: String? = UUID().uuidString
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Source: Decodable {
    let id: String?
    let name: String?
}
