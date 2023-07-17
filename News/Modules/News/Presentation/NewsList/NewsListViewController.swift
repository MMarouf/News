//
//  NewsListViewController.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import UIKit
import Foundation
import Combine

private enum Constants {
    static let rowHeight: CGFloat = 120
    static let filterImage = UIImage(named: "filterIcon")
    static let newsListAccessibilityLabel = "NewsListView"
    static let filterButtonAccessibilityLabel = "FilterButton"
}

final class NewsListViewController: UITableViewController {
    private let newsViewModel: NewsListViewModel
    private var filterVC: FilterViewController
    private var cancellables = Set<AnyCancellable>()
    init(newsViewModel: NewsListViewModel) {
        self.newsViewModel = newsViewModel
        filterVC = FilterViewController()
        super.init(style: .plain)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        self.view.accessibilityLabel = Constants.newsListAccessibilityLabel
        self.view.backgroundColor = UIColor.lightGray
        setupNavigationBar()
        prepareTableView()
        filterVC.modalPresentationStyle = .popover
        fetchHeadlines()
    }
    private func setupNavigationBar() {
        let filterButton = UIBarButtonItem(image: Constants.filterImage, style: .plain, target: self, action: #selector(filterCategory))
        filterButton.accessibilityLabel = Constants.filterButtonAccessibilityLabel
        self.navigationItem.rightBarButtonItem = filterButton
    }

    private func prepareTableView() {
        tableView.separatorStyle = .none
        tableView.register(ArticleCell.nib, forCellReuseIdentifier: ArticleCell.resueIdentifier)
        tableView.rowHeight = Constants.rowHeight
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    private func fetchHeadlines () {
        newsViewModel.$articleList
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] _ in
                self!.endRefreshing()
                self?.updateTitle()
                self?.tableView.reloadData()
            }
            .store(in: &self.cancellables)
    }
    private func endRefreshing() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    @objc func refreshAction () {
        newsViewModel.didListRefresh()
    }
    @objc func filterCategory () {
        filterVC.delegate = self
        navigationController?.present(filterVC, animated: true)
    }
    func updateTitle() {
        DispatchQueue.main.async { [weak self] in
            self?.title = self!.newsViewModel.getTitle()
        }
    }
}
extension NewsListViewController: FilterDelegate {
    func updateFilterInformation(category: Category, country: Country) {
        newsViewModel.updateSelection(country: country, category: category)
        updateTitle()
    }
}

extension NewsListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.articleList?.count ?? .zero
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.resueIdentifier) as? ArticleCell else {
            return UITableViewCell()
        }
        guard let article = newsViewModel.articleList?[indexPath.row] else { return UITableViewCell() }
        cell.fillCell(article: article)
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        newsViewModel.scrollDidReachAt(row: indexPath.row)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsViewModel = newsViewModel.getDetailsViewModelAt(indexPath: indexPath) else { return }
        pushToDetails(detailsViewModel: detailsViewModel)
    }
    private func pushToDetails (detailsViewModel: NewsDetailsViewModel) {
        let details = NewsDetailsViewController(detailsViewModel: detailsViewModel)
        navigationController?.pushViewController(details, animated: true)
    }
}
