//
//  PhotoViewModel.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation
import SwiftUI

class PhotoViewModel: ObservableObject, Hashable {
    fileprivate let photoModel: PhotoModel
    @Published var image = UIImage(systemName: "photo")!
    @Published var imageDownloadstate: DownloadState = .new
    
    init(photoModel: PhotoModel) {
        self.photoModel = photoModel
    }
    
    var displayedName: String {
        return photoModel.title
    }
    
    var imageURL: URL? {
        return photoModel.url
    }
    
    static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
        return lhs.photoModel.id == rhs.photoModel.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(photoModel.id)
    }
}

extension Array where Element == PhotoViewModel {
    func toModels() -> [PhotoModel] {
        return map { $0.photoModel }
    }
}
