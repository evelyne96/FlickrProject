//
//  PhotoSearchFeedViewModel.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 17/04/2021.
//

import Foundation

class PhotoSearchFeedViewModel: ObservableObject {
    private static let defaultSearchString = "Vizsla"
    private let flickrClient: FlickrAPIClient
    private var currentTask: Cancellable?
    private let pendingOperations: PendingImageOperations
    
    init(flickrClient: FlickrAPIClient) {
        self.flickrClient = flickrClient
        self.pendingOperations = PendingImageOperations()
        if let searchText = UserPrefs.shared.searchText, searchText.count > 0 {
            self.searchString = searchText
        } else {
            self.searchString = PhotoSearchFeedViewModel.defaultSearchString
        }
    }
    
    @Published var photoVMs = [PhotoViewModel]()
    @Published var searchString: String {
        didSet {
            startSearch()
        }
    }
    
    
    func startSearch() {
        UserPrefs.shared.searchText = searchString
        currentTask?.doCancel()
        pendingOperations.imageDownloadQueue.cancelAllOperations()
        currentTask = flickrClient.fetchSearchResults(text: searchString, page: 1, completion: { [weak self] result in
            switch result {
            case .success(let photosPage):
                self?.photoVMs = photosPage.photos.map{ PhotoViewModel(photoModel: $0) }
                self?.photoVMs.forEach{ self?.fetchImage(for: $0) }
            case .failure( _):
                break
            }
            self?.currentTask = nil
        })
    }
    
    private func fetchImage(for photoVM: PhotoViewModel) {
        guard let url = photoVM.imageURL, photoVM.imageDownloadstate != .downloaded else { return }
        photoVM.imageDownloadstate = .inProgress
        let op = ImageDownloadOperation(url: url) { result in
            switch result {
            case .success(let image):
                photoVM.imageDownloadstate = .downloaded
                photoVM.image = image
            case .failure(_):
                photoVM.imageDownloadstate = .failed
                break
            }
        }
        
        pendingOperations.imageDownloadQueue.addOperation(op)
    }
}
