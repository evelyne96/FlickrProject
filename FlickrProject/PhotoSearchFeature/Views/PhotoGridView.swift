//
//  PhotoGridView.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 19/04/2021.
//

import Foundation
import SwiftUI

struct PhotoGridView: View {
    @ObservedObject var dataSource: PhotoDataSource // TODO: this doesn't really need a searchfeedVM
    @State var gridLayout: [GridItem]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                ForEach(dataSource.items, id: \.self) { photoVM in
                    NavigationLink(destination: PhotoDetailView(photoVM: photoVM)) {
                        PhotoView(viewModel: photoVM).onAppear(perform: {
                            dataSource.loadNewDataIfNeeded(photoVM: photoVM)
                        })
                    }
                }
            }
            .padding(.all, 10)
        }
    }
}
