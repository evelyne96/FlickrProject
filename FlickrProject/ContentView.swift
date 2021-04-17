//
//  ContentView.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 17/04/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PhotoSearchFeedView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
