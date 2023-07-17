//
//  NewsDetailsViewController.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation
import Kingfisher

private enum Constants {
    static let newsDetailsAccessibilityLabel = "DetailsView"
    static let summaryViewCornerRadius: CGFloat = 10
}

final class NewsDetailsViewController: UIViewController {
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleSource: UILabel!
    @IBOutlet weak var articleDescription: UITextView!
    @IBOutlet weak var articleImage: UIImageView!
    init(detailsViewModel: NewsDetailsViewModel) {
        self.detailsViewModel = detailsViewModel
        super.init(nibName: NewsDetailsViewController.className, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let detailsViewModel: NewsDetailsViewModel
    override func viewWillAppear(_ animated: Bool) {
        self.view.accessibilityIdentifier = Constants.newsDetailsAccessibilityLabel
       prepareUI()
        updateViewContent(article: detailsViewModel.article)
    }
    func prepareUI () {
        summaryView.layer.masksToBounds = true
        summaryView.layer.cornerRadius = Constants.summaryViewCornerRadius
    }
    func updateViewContent (article: Article?) {
        self.title = article?.title
        articleTitle.text = article?.title
        articleDate.text = article?.publishedAt?.stringToDate().timeAgoDisplay()
        articleDescription.text = article?.description
        articleSource.text = article?.source.name
        if let image = article?.urlToImage {
            articleImage.kf.setImage(with: URL(string: image))
        }
    }
}
