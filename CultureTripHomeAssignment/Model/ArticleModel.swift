//
//  ArticleModel.swift
//  CultureTripHomeAssignment
//
//  Created by Adam Shulman on 15/10/2020.
//

import Foundation

struct Article {
    
    let id: String
    let title: String?
    let author: Author?
    let dateString: String?
    let category: String?
    let imagePathUrl: String?
    let isSaved: Bool?
    let isLiked: Bool?
    let likesCount: Int?
    
    init(dictionary: [AnyHashable : Any]) {
        
        self.id = dictionary["id"] as! String
        self.title = dictionary["title"] as? String
        self.category = dictionary["category"] as? String
        self.imagePathUrl = dictionary["imageUrl"] as? String
        self.isSaved = dictionary["isSaved"] as? Bool
        self.isLiked = dictionary["isLiked"] as? Bool
        self.likesCount = dictionary["likesCount"] as? Int
        
        if let authorDict = dictionary["author"] as? [AnyHashable : Any] {
            self.author = Author(dictionary: authorDict)
        }else{
            self.author = nil
        }
        
        if let metaDataDict = dictionary["metaData"] as? [AnyHashable : Any], let dateString = metaDataDict["creationTime"] as? String {
            
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: dateString)!
            dateFormatter.dateFormat = "MMM d, yyyy"
            dateFormatter.locale = tempLocale
            let dateString = dateFormatter.string(from: date)
            self.dateString = dateString
            
        }else{
            self.dateString = nil
        }
    }
}

struct Author {
    
    let id: String
    let name: String?
    let avatarPathUrl: String?
    
    init(dictionary: [AnyHashable : Any]) {
        self.id = dictionary["id"] as! String
        self.name = dictionary["authorName"] as? String
        if let authorAvatar = dictionary["authorAvatar"]  as? [AnyHashable : Any] {
            self.avatarPathUrl = authorAvatar["imageUrl"] as? String
        }else{
            self.avatarPathUrl = nil
        }
    }
}
