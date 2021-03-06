//
//  CacheTests.swift
//  CacherTests
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import Cacher

final class CacheTests: XCTestCase {
  func test_imageURL_caching_onMemory() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)),
      let key = imageURL.key else {
      XCTAssert(false, "no image at url")
      return
    }
    let expectation = self.expectation(description: "Testing caching of image from url and retrieving it back from cache.")
    let cache = Cacher.sharedCache
    cache.store((.memory, key), object: image) {
      cache.retrieve(from: .memory, key: key) { (image: UIImage?) in
        XCTAssert(image != nil, "no image")
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
  
  func test_imageURL_caching_onDisk() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let key = imageURL.key else {
        XCTAssert(false, "no json file at url")
        return
    }
    let expectation = self.expectation(description: "Testing caching of Image file from url and retrieving it back from cache.")
    let cache = Cacher.sharedCache
    _ = cache.download(cacheType: .disk, url: imageURL) { (object: Data?, cacheType) in
      cache.retrieve(from: .disk, key: key) { (data: Data?) in
        XCTAssert(data != nil, "no image file data")
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
  
  func test_disk_store() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)),
      let key = imageURL.key else {
        XCTAssert(false, "no json file at url")
        return
    }
    let expectation = self.expectation(description: "Testing caching of Image file from url and retrieving it back from cache.")
    let cache = Cacher.sharedCache
    cache.store((.disk, key), object: image) {
      cache.retrieve(from: .disk, key: key) { (data: Data?) in
        XCTAssert(data != nil, "no image file data")
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
  
  func test_performance_imageURL_caching_onMemory() {
    measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
      guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
        let image = try? UIImage(data: Data(contentsOf: imageURL)),
        let key = imageURL.key else {
          XCTAssert(false, "no image at url")
          return
      }
      let expectation = self.expectation(description: "Performance testing caching of image from url and retrieving it back from cache.")
      let cache = Cacher.sharedCache
      startMeasuring()
      cache.store((.memory, key), object: image) {
        cache.retrieve(from: .memory, key: key) { (image: UIImage?) in
          XCTAssert(image != nil, "no image")
          expectation.fulfill()
        }
      }
      waitForExpectations(timeout: 60, handler: { _ in
        self.stopMeasuring()
      })
    }
  }
  
  func test_cacher_download_onMemoryCache() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg") else {
      XCTAssert(false, "no image at url")
      return
    }
    let cache = Cacher.sharedCache
    _ = cache.download(cacheType: .memory, url: imageURL) { (object: Data?, _) in
      XCTAssert(object != nil, "no data found")
    }
  }
  
  func test_cacher_download_onDisk() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg") else {
      XCTAssert(false, "no image at url")
      return
    }
    let cache = Cacher.sharedCache
    _ = cache.download(cacheType: .disk, url: imageURL) { (object: Data?, _) in
      XCTAssert(object != nil, "no data found")
    }
  }
  
  func test_cacher_download_cancel() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg") else {
      XCTAssert(false, "no image at url")
      return
    }
    let cache = Cacher.sharedCache
    let token = cache.download(cacheType: .memory, url: imageURL) { (object: Data?, _) in
    }
    XCTAssert(cache.cancel(imageURL, token: token), "Cancel Error")
  }
  
  func test_cacher_memory_removeAll() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)),
      let key = imageURL.key else {
        XCTAssert(false, "no image at url")
        return
    }
    let cache = Cacher.sharedCache
    cache.store((.memory, key), object: image) {
      cache.removeAll()
      cache.retrieve(from: .memory, key: key, { (object: UIImage?) in
        XCTAssert(object == nil, "Cache not cleared.")
      })
    }
  }
}
