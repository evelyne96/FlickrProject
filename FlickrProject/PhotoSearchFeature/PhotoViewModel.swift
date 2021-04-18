//
//  PhotoViewModel.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation
import SwiftUI

class PhotoViewModel: ObservableObject, Hashable {
    private let photoModel: PhotoModel
    
    init(photoModel: PhotoModel) {
        self.photoModel = photoModel
    }
    
    @Published var image = UIImage(systemName: "face.smiling") ?? UIImage()
    
    var displayedName: String {
        return photoModel.title
    }
    
    static func == (lhs: PhotoViewModel, rhs: PhotoViewModel) -> Bool {
        return lhs.photoModel.id == rhs.photoModel.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(photoModel.id)
    }
}
