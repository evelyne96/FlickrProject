//
//  FlickrAPIClientProtocol.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation

enum FlickrSearchLoaderResult {
    case success(PhotoPageModel)
    case failure(Error)
}

protocol FlickrAPIClient: class {
    func fetchSearchResults(text: String, page: Int, completion: @escaping (FlickrSearchLoaderResult) -> Void) -> URLSessionTask?
}
