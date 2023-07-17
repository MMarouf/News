//
//  NewsTests.swift
//  NewsTests
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import XCTest
@testable import News

final class DataCountTest: XCTestCase {

    func testRetrieveCountryList () {
        let countryList = DataFetch().fetchCountryList()
        XCTAssertEqual(countryList.count, 8)
    }
    
    func testRetrieveCategoryList () {
        let categoryList = DataFetch().fetchCategoryList()
        XCTAssertEqual(categoryList.count, 8)
    }

}
