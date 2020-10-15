//
//  ArticleDetailViewController.swift
//  CultureTripHomeAssignment
//
//  Created by Adam Shulman on 15/10/2020.
//

import UIKit
import Kingfisher

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var writerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var writerImageView: UIImageView!
    
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews(with: article)
        
    }
    
    private func configureViews(with article: Article) {
        
        writerImageView.layer.cornerRadius = writerImageView.frame.size.width / 2
        writerImageView.layer.masksToBounds = true
        
        categoryLabel.text = article.category
        writerNameLabel.text = article.author?.name
        dateLabel.text = article.dateString
        titleLabel.text = article.title
        likesCountLabel.text = String(article.likesCount ?? 0)
        
        if let imagePath = article.imagePathUrl, let imageUrl = URL(string: imagePath) {
            backgroundImageView.kf.setImage(with: imageUrl)
        }
        
        if let imagePath = article.author?.avatarPathUrl, let imageUrl = URL(string: imagePath) {
            writerImageView.kf.setImage(with: imageUrl)
        }
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}

