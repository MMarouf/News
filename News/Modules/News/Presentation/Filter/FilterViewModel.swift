//
//  FilterViewModel.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation

final class FilterViewModel {
    var countryList: [Country] = []
    var categoryList: [Category] = []
    var selectedCountryIndex: Int = 0
    var selectedCategoryIndex: Int = 0

    func fetchDataList () {
        countryList = DataFetch().fetchCountryList()
        categoryList = DataFetch().fetchCategoryList()
    }
    func getSelectedCategory () -> Category {
        return categoryList[selectedCategoryIndex]
    }
    func getSelectedCountry () -> Country {
        return countryList[selectedCountryIndex]
    }
}
