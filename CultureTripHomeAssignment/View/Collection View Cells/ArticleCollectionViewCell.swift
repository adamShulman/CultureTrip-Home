//
//  ArticleCollectionViewCell.swift
//  CultureTripHomeAssignment
//
//  Created by Adam Shulman on 15/10/2020.
//

import UIKit
import Kingfisher

class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var writerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var writerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        writerImageView.layer.cornerRadius = writerImageView.frame.size.width / 2
        writerImageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        writerImageView.image = nil
    }
    
    public func configure(with article: Article) {
        
        categoryLabel.text = article.category
        writerNameLabel.text = article.author?.name
        dateLabel.text = article.dateString
        titleLabel.text = article.title
        
        if let imagePath = article.imagePathUrl, let imageUrl = URL(string: imagePath) {
            imageView.kf.setImage(with: imageUrl)
        }
        
        if let imagePath = article.author?.avatarPathUrl, let imageUrl = URL(string: imagePath) {
            writerImageView.kf.setImage(with: imageUrl)
        }
    }
}
