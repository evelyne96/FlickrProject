//
//  SwiftExtensions.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 17/04/2021.
//

import Alamofire
import Foundation
import SwiftUI

extension Font {
    static var photoDetailFont: Font {
        return Font.system(size: 14)
    }
    
    static var photoTitleFont: Font {
        return Font.system(size: 18)
    }
}

extension Request: Cancellable {
    func doCancel() {
        self.cancel()
    }
}

// https://developer.apple.com/documentation/swiftui/viewmodifier
struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }

}
