//
//  TestUtils.swift
//  FlickrProjectTests
//
//  Created by Suto, Evelyne on 21/04/2021.
//

import Foundation
@testable import FlickrProject

class CancallableTest: Cancellable {
    var cancelled = false
    func doCancel() { cancelled = true }
}

class ImageDataTestLoader: ImageAPIClient {
    var messages: [(url: URL, completion: (ImageLoaderResult) -> Void)] = []
    var requestedURLs: [URL] {
        return messages.map { $0.0 }
    }
    
    func fetchImage(url: URL,
                   lastModified: Date?,
                   completion: @escaping (ImageLoaderResult) -> Void) -> Cancellable {
        messages.append((url, completion))
        return CancallableTest()
    }
    
    func completeWith(result: ImageLoaderResult, index: Int = 0) {
        messages[index].completion(result)
    }
}

class FlickrDataTestLoader: FlickrAPIClient {
    struct SeachRequest: Equatable {
        let text: String
        let page: Int
    }
    var messages: [(searchReq: SeachRequest, completion: (FlickrSearchLoaderResult) -> Void)] = []
    var searchReqs: [SeachRequest] {
        return messages.map { $0.0 }
    }
    
    func fetchSearchResults(text: String, page: Int, completion: @escaping (FlickrSearchLoaderResult) -> Void) -> Cancellable? {
        let req = SeachRequest(text: text, page: page)
        messages.append((req, completion))
        
        return CancallableTest()
    }
    
    func completeWith(result: FlickrSearchLoaderResult, index: Int = 0) {
        messages[index].completion(result)
    }
}
