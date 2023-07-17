//
//  NewsAPIClientMock.swift
//  NewsTests
//
//  Created by Mohamed Marouf on 17/07/2023.
//

@testable import News

final class NewsAPIClientMock: NewsAPIClientProtocol {
    enum ResponseResult {
        case success
        case failed(error: APIError)
    }
    var result: ResponseResult = .failed(error: .badRequest)
    func fetchTopHeadline(country: Country, category: Category, page: Int, pageSize: Int) async -> Result<Headline, APIError> {
        switch result {
        case .success:
            return .success(.mock())
        case .failed(let error):
            return .failure(error)
        }
    }
}
