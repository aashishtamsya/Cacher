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
  func testCachable() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)) else {
      XCTAssert(false, "no image at url")
      return
    }
    let cache = Cacher.sharedCache
    cache.store(key: "image", object: image, completion: nil)
    cache.retrieve(key: "image") { (image: UIImage?) in
      XCTAssert(image != nil, "no image")
    }
  }
  
  func testPerformanceCachable() {
    measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
      guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
        let image = try? UIImage(data: Data(contentsOf: imageURL)) else {
          XCTAssert(false, "no image at url")
          return
      }
      let cache = Cacher.sharedCache
      startMeasuring()
      cache.store(key: "image", object: image, completion: nil)
      cache.retrieve(key: "image") { (image: UIImage?) in
        XCTAssert(image != nil, "no image")
        self.stopMeasuring()
      }
    }
  }
}
