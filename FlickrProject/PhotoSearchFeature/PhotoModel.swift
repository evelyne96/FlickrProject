//
//  PhotoModel.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation

struct PhotoModel: Decodable {
    let id: String
    let title: String
    let owner: String
    let secret: String?
    let server: String?
    let isPublic: Int?
    let url: URL?
    
    enum CodingKeys: String, CodingKey {
        case id, title, owner, secret, server
        
        case isPublic = "ispublic"
        case url = "url_m"
    }
}
