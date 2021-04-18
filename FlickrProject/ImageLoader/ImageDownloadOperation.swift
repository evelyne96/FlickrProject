//
//  ImageDownloadOperation.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation
import UIKit

class ImageDownloadOperation: AsyncOperation {
    let url: URL
    let imageCompletionBlock: (ImageLoaderResult) -> Void
    var request: Cancellable?
    
    init(url: URL, completionBlock: @escaping (ImageLoaderResult) -> Void) {
        self.url = url
        self.imageCompletionBlock = completionBlock
    }
    
    override func execute() {
        request = ImageDataLoader.fetchImage(url: self.url, lastModified: nil) { [weak self] (result) in
            self?.imageCompletionBlock(result)
            self?.executeCompleted?()
        }
    }
    
    override func cancel() {
        super.cancel()
        request?.doCancel()
    }
}

class PendingImageOperations {
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "ImageDownloadQueue queue"
        queue.maxConcurrentOperationCount = 4
        return queue
    }()
}
