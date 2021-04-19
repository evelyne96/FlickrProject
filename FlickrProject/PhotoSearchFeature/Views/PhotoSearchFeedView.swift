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
            PhotoGridView(dataSource: viewModel.dataSource, gridLayout: gridLayout).navigationBarTitle("Search Photos").onLoad {
                viewModel.startSearch()
            }
        }
    }
}
