//
//  PhotoView.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 19/04/2021.
//

import Foundation
import SwiftUI

struct PhotoView: View {
    @ObservedObject var viewModel: PhotoViewModel
    
    var body: some View {
        if viewModel.imageDownloadstate == .inProgress {
            ProgressView().frame(minWidth: 0, maxWidth: .infinity).frame(height: 200)
        } else {
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(10)
                .shadow(color: Color.primary.opacity(0.3), radius: 1)
        }
    }
}
