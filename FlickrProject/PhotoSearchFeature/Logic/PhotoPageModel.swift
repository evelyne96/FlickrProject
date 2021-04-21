//
//  PhotoPageModel.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation

public enum DataError: Error, Equatable {
    case invalidData
}

struct Photos: Decodable {
    let photoPage: PhotoPageModel
    let stat: String
    
    enum CodingKeys: String, CodingKey {
        case photoPage = "photos"
        case stat
    }
}

struct PhotoPageModel: Decodable {
    let page: Int
    let pages: Int
    let total: Int
    let photos: [PhotoModel]
    
    init(page: Int, pages: Int, total: Int, photos: [PhotoModel]) {
        self.page = page
        self.pages = pages
        self.total = total
        self.photos = photos
    }
    
    enum CodingKeys: String, CodingKey {
        case page, pages, total
        case photos = "photo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        guard let total = Int(try values.decode(String.self, forKey: .total)) else {
            throw DataError.invalidData
        }
        
        self.page = try values.decode(Int.self, forKey: .page)
        self.pages = try values.decode(Int.self, forKey: .pages)
        self.total = total
        self.photos = try values.decode([PhotoModel].self, forKey: .photos)
    }
}
