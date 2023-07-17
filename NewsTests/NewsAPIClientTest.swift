//
//  NewsAPIClientTest.swift
//  NewsTests
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import XCTest
@testable import News

private enum Constants {
    enum success {
        static let country = Country(iso: "us", name: "United States")
        static let category = Category(name: "health")
    }
    
    enum failure {
        static let country = Country(iso: "usa", name: "United")
        static let category = Category(name: "Music")
    }
}

final class NewsAPIClientTest: XCTestCase {
    var sut = NewsAPIClientMock()
    func testNewsAPIClientNotNull () async {
        let country = Country(iso: "us", name: "United States")
        let category = Category(name: "health")
        let endpoint = NewsAPIClient()
        let result = await endpoint.fetchTopHeadline(country: country, category: category, page: 1, pageSize: 10)
        switch result {
        case .success(let headline):
            XCTAssertNotNil(headline)
        case .failure(let error):
            print("error: \(error)")
        }
    }
    
    func testNewsAPIClientSuccess() async {
        sut.result = .success
        
        let result = await sut.fetchTopHeadline(country: Constants.success.country, category: Constants.success.category, page: 1, pageSize: 10)
        
        switch result {
        case .success(let headline):
            XCTAssertEqual(headline.status, Headline.mock().status)
        case .failure:
            print("failed")
        }
    }
    
    func testNewsAPIClientWithBadRequestError() async {
        sut.result = .failed(error: .badRequest)
                
        let result = await sut.fetchTopHeadline(country: Constants.success.country, category: Constants.success.category, page: 1, pageSize: 10)
        
        switch result {
        case .success(_):
            print("success")
        case .failure(let error):
            XCTAssertEqual(error, .badRequest)
        }
    }
    
    
    func testNewsAPIClientArticleCount () async {
        let country = Country(iso: "us", name: "United States")
        let category = Category(name: "health")
        let endpoint = NewsAPIClient()
        let result  = await endpoint.fetchTopHeadline(country: country, category: category, page: 1, pageSize: 10)
        switch result {
        case .success(let headline):
            XCTAssertEqual(headline.articles.count , 10)
        case .failure(let error):
            print("error: \(error)")
        }
    }
    
    func testNewsAPIClientFailure () async {
        let country = Country(iso: "us", name: "United States")
        let category = Category(name: "health")
        let endpoint = NewsAPIClient()
        let result  = await endpoint.fetchTopHeadline(country: country, category: category, page: 1, pageSize: 10)
        switch result {
        case .success(let headline):
            print (headline.articles.count)
        case .failure(let error):
            XCTAssertEqual(error, APIError.offlineConnection)
        }
    }
    
    func testNewsAPIClientInvalidCategory () async {
        let country = Country(iso: "us", name: "United States")
        let category = Category(name: "healths")
        let endpoint = NewsAPIClient()
        let result  = await endpoint.fetchTopHeadline(country: country, category: category, page: 1, pageSize: 10)
        switch result {
        case .success(let headline):
            XCTAssertEqual(headline.totalResults , 0 )
        case .failure(let error):
            print("error: \(error)")
        }
    }
    
    func testNewsAPIClientInvalidCountry () async {
        let country = Country(iso: "usa", name: "United States")
        let category = Category(name: "health")
        let endpoint = NewsAPIClient()
        let result  = await endpoint.fetchTopHeadline(country: country, category: category, page: 1, pageSize: 10)
        switch result {
        case .success(let headline):
            XCTAssertEqual(headline.totalResults , 0 )
        case .failure(let error):
            print("error: \(error)")
        }
    }

}
