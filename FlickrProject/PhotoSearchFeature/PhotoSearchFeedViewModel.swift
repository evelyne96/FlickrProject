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
    
    @Published var photoVMs = [PhotoViewModel]()
    @Published var searchString: String = "dog" {
        didSet {
            // TODO: cancel last photo search
            // kick off a new photo search
            currentTask?.cancel()
            currentTask = flickrClient.fetchSearchResults(text: searchString, page: 1, completion: { [weak self] result in
                switch result {
                case .success(let photosPage):
                    self?.photoVMs = photosPage.photos.map{ PhotoViewModel(photoModel: $0) }
                case .failure( _):
                    break
                }
                self?.currentTask = nil
            })
        }
    }
}
