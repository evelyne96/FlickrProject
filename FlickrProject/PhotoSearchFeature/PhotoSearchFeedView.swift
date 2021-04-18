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
    
    @State var gridLayout: [GridItem] = [ GridItem(.adaptive(minimum: 200, maximum: 400)), GridItem(.adaptive(minimum: 200, maximum: 400)) ]
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchString)
            
            ScrollView {
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(viewModel.photoVMs, id: \.self) { photoVM in
                        NavigationLink(destination: PhotoDetailView(photoVM: photoVM)) {
                            PhotoView(viewModel: photoVM)
                        }
                    }
                }
                .padding(.all, 10)
            }.navigationBarTitle("Search Photos")
        }
    }
}
