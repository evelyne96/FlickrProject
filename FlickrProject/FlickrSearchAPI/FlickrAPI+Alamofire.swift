//
//  FlickrAPI+Alamofire.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation
import Alamofire

public enum RequestCreationError: Error, Equatable {
    case failedToCreateRequest
}

// Support for alamofire request creation
extension FlickrAPI: URLRequestConvertible {
    public func asURLRequest() throws -> URLRequest {
        switch self {
        case .searchPhotos(let apiKey, let method, let format, let noJsonCallback, let perPage, let sort, let extras, let page, let keyword):
            let url = FlickrAPI.rootURL
            let request = URLRequest(url: url.appendingPathComponent(FlickrAPI.restPath))
            let params = [FlickrAPI.params.apiKey.paramKey: apiKey,
                          FlickrAPI.params.method.paramKey: method.description,
                          FlickrAPI.params.format.paramKey: format.description,
                          FlickrAPI.params.sort.paramKey: sort.description,
                          FlickrAPI.params.perPage.paramKey: "\(perPage)",
                          FlickrAPI.params.noJSONCallback.paramKey: noJsonCallback,
                          FlickrAPI.params.extras.paramKey: extras,
                          FlickrAPI.params.photoSearchText.paramKey: keyword,
                          FlickrAPI.params.page.paramKey: "\(page)"]
            
            return try URLEncoding.default.encode(request, with: params as Parameters)
        }
    }
}
