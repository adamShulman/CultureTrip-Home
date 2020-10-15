//
//  ArticlesViewController.swift
//  CultureTripHomeAssignment
//
//  Created by Adam Shulman on 15/10/2020.
//

import UIKit

class ArticlesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var articles: [Article] = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCollectionView()
        fetchArticles()
        
    }
    
    private func fetchArticles() {
        downloadArticles { (articles) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                guard let articlesArray = articles else { return }
                self.articles = articlesArray
                self.collectionView.reloadData()
            }
        }
    }
    
    private func initializeCollectionView() {
        collectionView.register(UINib(nibName: "ArticleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleDetails", let vc = segue.destination as? ArticleDetailViewController, let article = sender as? Article {
            vc.article = article
        }
    }
}

extension ArticlesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCollectionViewCell
        
        let article = articles[indexPath.row]
        cell.configure(with: article)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articles[indexPath.item]
        performSegue(withIdentifier: "articleDetails", sender: article)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 30.0, height: view.frame.size.height / 1.3)
    }
}

extension ArticlesViewController {
    
    fileprivate func downloadArticles(completion: @escaping ([Article]?) -> ()) {
        
        guard let url = URL(string: "https://cdn.theculturetrip.com/home-assignment/response.json") else { return }
        let request = URLRequest(url: url)
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            if error == nil && statusCode == 200 {
                
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                guard let articles = self.parseRequest(responseData: data) else {
                    completion(nil)
                    return
                }
                
                completion(articles)
            }
        }
        task.resume()
    }
    
    fileprivate func parseRequest(responseData: Data) -> [Article]? {
        do {
            let jsonData = try JSONSerialization.jsonObject(with: responseData , options: .allowFragments)
            if let jsonObject = jsonData as? [AnyHashable : Any]{
                if let dataArray = jsonObject["data"] as? [[AnyHashable : Any]] {
                    
                    var articlesArray = [Article]()
                    
                    for articleObject in dataArray {
                        let article = Article(dictionary: articleObject)
                        articlesArray.append(article)
                    }
                    
                    return articlesArray
                }
            }
            return nil
        } catch { return nil }
    }
}
