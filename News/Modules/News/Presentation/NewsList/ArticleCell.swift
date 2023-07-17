//
//  ArticleCell.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation
import Kingfisher

private enum Constants {
    static let cornerRadius: CGFloat = 10
    static let placeholderImage = UIImage(named: "news-placeholder")
}

final class ArticleCell: UITableViewCell {
    @IBOutlet private weak var articelImage: UIImageView!
    @IBOutlet private weak var articleTitle: UILabel!
    @IBOutlet private weak var articelTime: UILabel!
    @IBOutlet private weak var articleSource: UILabel!
    @IBOutlet private weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    func configure() {
        articelImage.layer.cornerRadius = Constants.cornerRadius
        articelImage.layer.masksToBounds = true
        backView.layer.cornerRadius = Constants.cornerRadius
        backView.layer.masksToBounds = true
    }
    func fillCell(article: Article) {
        self.articleTitle.text = article.title
        self.articleSource.text = article.source.name
        if let dateFrom = article.publishedAt {
            self.articelTime.text = dateFrom.stringToDate().timeAgoDisplay()
        }
        if let image = article.urlToImage {
            DispatchQueue.main.async {
                self.articelImage.kf.setImage(with: URL(string: image))
            }
        } else {
            self.articelImage.image = Constants.placeholderImage
        }
    }
}
