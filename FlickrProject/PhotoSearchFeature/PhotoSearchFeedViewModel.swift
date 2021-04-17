//
//  PhotoSearchFeedViewModel.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 17/04/2021.
//

import Foundation

class PhotoSearchFeedViewModel: ObservableObject {
    private let names = ["Eve", "Evelyne", "Zoli", "Juli", "Sanyi"]
    @Published var searchResult = [String]()
    @Published var searchString: String = "dog" {
        didSet {
            // TODO: cancel last photo search
            // kick off a new photo search
            searchResult = searchString.count == 0 ? names : names.filter { $0.hasPrefix(searchString) }
        }
    }
}
