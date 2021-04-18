//
//  PhotoSearchFeedView.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 17/04/2021.
//

import Foundation
import SwiftUI

struct PhotoSearchFeedView: View {
    @ObservedObject var viewModel = PhotoSearchFeedViewModel(flickrClient: FlickrDataLoader())
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchString)
            List(viewModel.photoVMs, id: \.self) { photoVM in
                NavigationLink(destination: PhotoDetailView(photoVM: photoVM)) {
                    PhotoRowView(photoViewModel: photoVM)
                }
            }.navigationBarTitle("Search Photos")
        }
    }
}
