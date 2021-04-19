//
//  PhotoDetailView.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation
import SwiftUI

struct PhotoDetailView: View {
    @ObservedObject var photoVM: PhotoViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: photoVM.image)
                    .resizable()
                    .scaledToFit()
                Spacer()
                VStack(alignment: .center, spacing: 15) {
                    Text(photoVM.displayedName)
                        .font(Font.photoTitleFont)
                }
                Spacer()
            }
        }
    }
}
