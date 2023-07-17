//
//  NewsAPIClient.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation

protocol NewsAPIClientProtocol {
    func fetchTopHeadline(country: Country, category: Category, page: Int, pageSize: Int) async -> Result<Headline, APIError>
}

struct NewsAPIClient: NewsAPIClientProtocol, WebService {
    func fetchTopHeadline(country: Country, category: Category, page: Int, pageSize: Int) async -> Result<Headline, APIError> {
        await fetch(endpoint: NewsEndpoint.fetchTopHeadline(country: country, category: category, page: page, pageSize: pageSize))
    }
}
