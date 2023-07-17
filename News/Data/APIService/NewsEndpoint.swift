//
//  NewsEndpoint.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation

private enum Constants {
    static let baseUrl = "https://newsapi.org/v2/"
    static let topHeadlines = "top-headlines"
    static let APIKeyValue = "3f0f5bf70aff419b919954c8bb8e5169"
    static let APIKey = "apiKey"

    static let countryKey = "country"
    static let pageKey = "page"
    static let pageSize = "pageSize"
    static let categoryKey = "category"
    static let allNewsText = "All News"
}

enum NewsEndpoint {
    case fetchTopHeadline(country: Country, category: Category?, page: Int, pageSize: Int)
}

extension NewsEndpoint: Endpoint {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseUrl) else { fatalError("Failed to generate base url") }
        return url
    }
    var path: String {
        switch self {
        case .fetchTopHeadline: return Constants.topHeadlines
        }
    }
    var method: HTTPRequestMethod {
        switch self {
        case .fetchTopHeadline: return .get
        }
    }
    var headers: [String: String]? {
        return nil
    }
    var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchTopHeadline(let country, let category, let page, let pageSize):
            var parameters = [
                URLQueryItem(name: Constants.APIKey, value: Constants.APIKeyValue),
                URLQueryItem(name: Constants.pageKey, value: "\(page)"),
                URLQueryItem(name: Constants.pageSize, value: "\(pageSize)"),
                URLQueryItem(name: Constants.countryKey, value: country.iso)
            ]
            if let category = category, category.name != Constants.allNewsText {
                parameters.append(URLQueryItem(name: Constants.categoryKey, value: category.name))
            }
            return parameters
        }
    }
    var parameters: [String: Any]? {
        return nil
    }
}
