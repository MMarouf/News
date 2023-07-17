//
//  NewsListViewModel.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import UIKit
import Foundation
import Combine

private enum Constants {
    static let allNewsText = "All News"
}

final class NewsListViewModel {
    struct Dependencies {
        let apiService: NewsAPIClientProtocol
    }
    private let dependencies: Dependencies
    private var pageSize = 10
    private var page = 1
    private var hasMore = true
    private var currentCategory: Category
    private var currentCountry: Country
    @Published var articleList: [Article]?
    private var loadMore = false
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        let dataFetchService = DataFetch()
        currentCountry = dataFetchService.fetchCountryList()[0]
        currentCategory = dataFetchService.fetchCategoryList()[0]
        self.fetchHeadlines()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setDefault() {
        page = 1
        hasMore = true
        articleList?.removeAll()
    }
    func scrollDidReachAt (row: Int) {
        if row == articleList!.count - 2 && hasMore {
            page += 1
            loadMore = true
            fetchHeadlines()
        }
    }
    func didListRefresh() {
        setDefault()
        fetchHeadlines()
    }
    func updateSelection (country: Country, category: Category) {
        currentCategory = category
        currentCountry = country
        page = 1
        hasMore = true
        fetchHeadlines()
    }
    func getTitle () -> String {
        if currentCategory.name == Constants.allNewsText {
            return " \(Constants.allNewsText) - \(currentCountry.iso)"
        }
        return "\(currentCategory.name ) - \(currentCountry.iso) "
    }
     private func fetchHeadlines () {
        Task {
            let result = await self.dependencies.apiService.fetchTopHeadline(country: self.currentCountry, category: self.currentCategory, page: self.page, pageSize: self.pageSize)
            switch result {
            case .success(let headline):
                updateArticleList(articles: headline.articles)
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    private func updateArticleList (articles: [Article]) {
        if articles.isEmpty { hasMore = false ; return }
        self.articleList = loadMore ? self.articleList! + articles : articles
        loadMore = false
    }
    func getDetailsViewModelAt(indexPath: IndexPath) -> NewsDetailsViewModel? {
        guard let article = self.articleList?[indexPath.row] else { return nil }
        return NewsDetailsViewModel(article: article)
    }
}
