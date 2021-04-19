//
//  PhotoSearchFeedViewModel.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 17/04/2021.
//

import Foundation

class PhotoSearchFeedViewModel: ObservableObject {
    private static let defaultSearchString = "Vizsla"
    let dataSource: PhotoDataSource
    
    init(flickrClient: FlickrAPIClient) {
        self.dataSource = PhotoDataSource(apiClient: flickrClient)
        if let searchText = UserPrefs.shared.searchText, searchText.count > 0 {
            self.searchString = searchText
        } else {
            self.searchString = PhotoSearchFeedViewModel.defaultSearchString
        }
    }
    
    @Published var searchString: String {
        didSet {
            startSearch()
        }
    }
    
    func startSearch() {
        dataSource.startNewSearch(text: searchString)
    }
}
