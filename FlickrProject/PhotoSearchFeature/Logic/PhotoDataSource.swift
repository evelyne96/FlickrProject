//
//  PhotoDataSource.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 19/04/2021.
//

import Foundation

// TODO:  Does not handle any error if no more page is available + overall the whole app doesn't do any error handling
class PhotoDataSource: ObservableObject {
    @Published var items = [PhotoViewModel]()
    
    private var currentPage = 1
    private var currentTask: Cancellable?
    private let pendingOperations: PendingImageOperations
    private let flickrClient: FlickrAPIClient
    private let threshHold = 5
    
    init(apiClient: FlickrAPIClient) {
        self.pendingOperations = PendingImageOperations()
        self.flickrClient = apiClient
    }
    
    func startNewSearch(text: String) {
        resetSearch()
        UserPrefs.shared.searchText = text
        search(text: text)
    }
    
    private func resetSearch() {
        currentTask?.doCancel()
        pendingOperations.imageDownloadQueue.cancelAllOperations()
        currentPage = 1
        items = []
    }
    
    private func search(text: String) {
        currentTask = flickrClient.fetchSearchResults(text: text, page: currentPage, completion: { [weak self] result in
            switch result {
            case .success(let photosPage):
                self?.items += photosPage.photos.map{ PhotoViewModel(photoModel: $0) }
                self?.items.forEach{ self?.fetchImage(for: $0) }
            case .failure( _):
                break
            }
            self?.currentTask = nil
        })
    }
    
    func loadNewDataIfNeeded(photoVM: PhotoViewModel) {
        guard let index = items.firstIndex(of: photoVM), let searchText = UserPrefs.shared.searchText, items.count - index < threshHold else { return }
        currentPage += 1
        search(text: searchText)
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
