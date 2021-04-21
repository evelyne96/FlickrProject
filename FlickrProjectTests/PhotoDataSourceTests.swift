//
//  FlickrProjectTests.swift
//  FlickrProjectTests
//
//  Created by Suto, Evelyne on 17/04/2021.
//

import XCTest
@testable import FlickrProject

class PhtoDataSourceTests: XCTestCase {
    
    func testSearchTextChangeFetchesNewResult() throws {
        let (_, searchAPI, sut) = makeSUT()
        let searchText1 = "text1"
        sut.startNewSearch(text: searchText1)
        let expextedMessages = [FlickrDataTestLoader.SeachRequest(text: searchText1, page: 1)]
        XCTAssertEqual(searchAPI.searchReqs, expextedMessages)
    }
    
    func testSearchTextPopulatesItemsOnSuccessfullFetch() throws {
        let (_, searchAPI, sut) = makeSUT()
        let photo = makePhoto(id: "Identifier")
        let page = makePhotoPage(page: 1, pages: 1, total: 1, photos: [photo])
        
        let searchText1 = "text1"
        sut.startNewSearch(text: searchText1)
        searchAPI.completeWith(result: .success(page))
        XCTAssertEqual(sut.items.toModels(), page.photos)
    }
    
    
    func testSearchStartsImageLoadingOnSuccessfullFetch() throws {
        let (imageLoader, searchAPI, sut) = makeSUT()
        let imageURL = anyURL()
        let photo = makePhoto(id: "Identifier", url: imageURL)
        let page = makePhotoPage(page: 1, pages: 1, total: 1, photos: [photo])
        
        let searchText1 = "text1"
        sut.startNewSearch(text: searchText1)
        searchAPI.completeWith(result: .success(page))
        XCTAssertEqual(sut.items.toModels(), page.photos)
        XCTAssertEqual(imageLoader.requestedURLs, [imageURL])
    }
    
    func makeSUT() -> (imageLoader: ImageDataTestLoader, searchAPI: FlickrDataTestLoader, ds: PhotoDataSource) {
        let imgLoader = ImageDataTestLoader()
        let searchAPI = FlickrDataTestLoader()
        let ds = PhotoDataSource(apiClient: searchAPI, imageLoader: imgLoader)
        
        return (imgLoader, searchAPI, ds)
    }
    
    private func jsonDict(photo: PhotoModel) -> [String: Any] {
        let dict: [String: Any?] = ["id": photo.id,
                                    "title": photo.title,
                                    "owner": photo.owner,
                                    "ispublic": photo.isPublic,
                                    "server": photo.server,
                                    "url_m": photo.url]
        
        return dict.reduce(into: [String: Any]()) { (acc, element) in
            if let v = element.value { acc[element.key] = v }
        }
    }
    
    private func jsonDict(page: PhotoPageModel) -> [String: Any] {
        let dict: [String: Any?] = ["page": page.page,
                                    "pages": page.pages,
                                    "total": page.total,
                                    "photo": page.photos.map { jsonDict(photo: $0)} ]
        
        return dict.reduce(into: [String: Any]()) { (acc, element) in
            if let v = element.value { acc[element.key] = v }
        }
    }
    
    private func makePhoto(id: String,
                          title: String = "",
                          owner: String = "",
                          secret: String? = nil,
                          server: String? = nil,
                          isPublic: Int? = nil,
                          url: URL? = nil) -> PhotoModel {
        return PhotoModel(id: id, title: title, owner: owner, secret: secret, server: server, isPublic: isPublic, url: url)
    }
    
    private func makePhotoPage(page: Int, pages: Int, total: Int, photos: [PhotoModel]) -> PhotoPageModel {
        return PhotoPageModel(page: page, pages: pages, total: total, photos: photos)
    }
    
    private func photoResult(page: PhotoPageModel, stat: String = "OK") -> (Photos, [String: Any]) {
        let photos = Photos(photoPage: page, stat: stat)
        let json = ["stat": stat, "photos": jsonDict(page: page)] as [String : Any]
        return (photos, json)
    }
    
    private func makeJSONDataWithIPhotos(photos: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: photos)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
