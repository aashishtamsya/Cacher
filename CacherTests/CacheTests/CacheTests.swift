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
  func test_imageURL_caching() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)),
      let key = imageURL.key else {
      XCTAssert(false, "no image at url")
      return
    }
    let expectation = self.expectation(description: "Testing caching of image from url and retrieving it back from cache.")
    let cache = Cacher.sharedCache
    cache.store(to: .memory, key: key, object: image) {
      cache.retrieve(from: .memory, key: key) { (image: UIImage?) in
        XCTAssert(image != nil, "no image")
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
  
  func test_performance_imageURL_caching() {
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
      cache.store(to: .memory, key: key, object: image) {
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
}
