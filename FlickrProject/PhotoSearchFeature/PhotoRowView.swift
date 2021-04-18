//
//  PhotoRowView.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation
import SwiftUI

struct PhotoRowView: View {
    @ObservedObject var photoViewModel: PhotoViewModel
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image(uiImage: photoViewModel.image)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
            }
            VStack(alignment: .center, spacing: 15) {
                Text(photoViewModel.displayedName)
                    .font(Font.photoTitleFont)
            }
        }
    }
}
