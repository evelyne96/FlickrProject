//
//  FlickrAPIClient.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Alamofire
import Foundation

//https://www.flickr.com/services/api/flickr.photos.search.html

class FlickrDataLoader: FlickrAPIClient {
    func fetchSearchResults(text: String, page: Int, completion: @escaping (FlickrSearchLoaderResult) -> Void) -> URLSessionTask? {
        guard let request = FlickrAPI.searchPhotos(page: page, keyword: text).urlRequest else {
            completion(.failure(RequestCreationError.failedToCreateRequest))
            return nil
        }
        
        let afrequest = AF.request(request)
        afrequest.validate(statusCode: 200..<304).responseDecodable(of: Photos.self) { response in
            switch response.result {
            case .success(let photos):
                completion(.success(photos.photoPage))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return afrequest.task
    }
}
