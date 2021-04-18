//
//  FlickrAPI.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation
import Alamofire

protocol ParameterDescriptor {
    var paramKey: String { get }
}

public enum FlickrAPI {
    case searchPhotos(apiKey: String = apiKey,
                      method: FlickrAPI.method = FlickrAPI.method.photoSearch,
                      format: FlickrAPI.supportedFormat = FlickrAPI.supportedFormat.json,
                      noJSONCallback: String = "1",
                      perPage: Int = 20,
                      sort: FlickrAPI.supportedSort = FlickrAPI.supportedSort.relevant,
                      extras: String = "url_m",
                      page: Int = 1,
                      keyword: String)
}

extension FlickrAPI {
    public static var apiKey: String { return "65803e8f6e4a3982200621cad356be51" }
    public static var root: String { return "https://www.flickr.com/" }
    public static var rootURL: URL { return URL(string: FlickrAPI.root)! }
    public static var restPath: String { return "services/rest" }
}

// Param helpers
extension FlickrAPI {
    public enum params: ParameterDescriptor {
        case apiKey
        case method
        case format
        case sort
        case perPage
        case noJSONCallback
        case extras
        case photoSearchText
        case page
        
        var paramKey: String {
            switch self {
            case .apiKey:
                return "api_key"
            case .method:
                return "method"
            case .format:
                return "format"
            case .sort:
                return "sort"
            case .perPage:
                return "per_page"
            case .noJSONCallback:
                return "nojsoncallback"
            case .extras:
                return "extras"
            case .photoSearchText:
                return "text"
            case .page:
                return "page"
            }
        }
    }
    
    public enum method: CustomStringConvertible {
        case photoSearch
        
        public var description: String {
            switch self {
            case .photoSearch:
                return "flickr.photos.search"
            }
        }
    }
    
    public enum supportedFormat: CustomStringConvertible {
        case json
        
        public var description: String {
            switch self {
            case .json:
                return "json"
            }
        }
    }
    
    public enum supportedSort: CustomStringConvertible {
        case datePostedAsc
        case datePostedDesc
        case interestingAsc
        case interestingDesc
        case relevant
        
        public var description: String {
            switch self {
            case .datePostedAsc:
                return "date-posted-asc"
            case .datePostedDesc:
                return "date-posted-desc"
            case .interestingAsc:
                return "interestingness-asc"
            case .interestingDesc:
                return "interestingness-desc"
            case .relevant:
                return "relevance"
            }
        }
    }
}
