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
