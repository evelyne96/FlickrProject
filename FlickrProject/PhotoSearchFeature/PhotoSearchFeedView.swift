//
//  PhotoSearchFeedView.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 17/04/2021.
//

import Foundation
import SwiftUI

struct PhotoSearchFeedView: View {
    @ObservedObject var viewModel = PhotoSearchFeedViewModel()
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchString)
            List(viewModel.searchResult, id: \.self) { name in
                Text(name)
                
            }.navigationBarTitle("Search Photos")
        }
    }
}
