//
//  PhotoSearchFeedViewModel.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 17/04/2021.
//

import Foundation

class PhotoSearchFeedViewModel: ObservableObject {
    private let flickrClient: FlickrAPIClient
    private var currentTask: URLSessionTask?
    
    init(flickrClient: FlickrAPIClient) {
        self.flickrClient = flickrClient
    }
    
    @Published var searchResult = [String]()
    @Published var searchString: String = "dog" {
        didSet {
            // TODO: cancel last photo search
            // kick off a new photo search
            currentTask?.cancel()
            currentTask = flickrClient.fetchSearchResults(text: searchString, page: 5, completion: { [weak self] result in
                switch result {
                case .success( _):
                    break
                case .failure( _):
                    break
                }
                self?.currentTask = nil
            })
        }
    }
}
