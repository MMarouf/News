//
//  DataFetch.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

class DataFetch {
    func fetchCategoryList () -> [Category] {
        return [
            Category(name: "All News"),
            Category(name: "business"),
            Category(name: "entertainment"),
            Category(name: "general"),
            Category(name: "health"),
            Category(name: "science"),
            Category(name: "sports"),
            Category(name: "technology")]
    }
    func fetchCountryList () -> [ Country ] {
        return [
            Country(iso: "us", name: "United States"),
            Country(iso: "ae", name: "United Arab Emirates"),
            Country(iso: "ar", name: "Argentina"),
            Country(iso: "at", name: "Austria"),
            Country(iso: "au", name: "Australia"),
            Country(iso: "be", name: "Belgium"),
            Country(iso: "bg", name: "Bulgaria"),
            Country(iso: "br", name: "Brazil")
        ]
    }
}
