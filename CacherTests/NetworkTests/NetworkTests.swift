//
//  NetworkTests.swift
//  CacherTests
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import Cacher

final class NetworkTests: XCTestCase {
  func testDownloadable() {
    guard let imageURL = URL(string: "https://blog.hubspot.com/hubfs/image8-2.jpg") else {
      XCTAssert(false, "no image at url")
      return
    }
    let expectation = self.expectation(description: "Download and cache image")
    let cache = Cacher.sharedCache
    cache.download(url: imageURL) { (object: Data?, _)  in
      cache.retrieve(key: imageURL.absoluteString, completion: { (data: Data?) in
        if let data = data {
          let image = UIImage(data: data)
          XCTAssert(image != nil, "no image in cache.")
        } else {
          XCTAssert(false, "no data from url.")
        }
        expectation.fulfill()
      })
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
  
  func testPerformanceExample() {
    measureMetrics([.wallClockTime], automaticallyStartMeasuring: false) {
      guard let url = URL(string: "https://cdn.pixabay.com/photo/2016/09/01/10/23/image-1635747_960_720.jpg") else {
        XCTAssert(false)
        return
      }
      let cache = Cacher.sharedCache
      let expectation = self.expectation(description: "Downloading image and cache it.")
      startMeasuring()
      cache.download(url: url) { (object: Data?, _) in
        cache.memoryCache.retrieve(key: url.absoluteString, completion: { (data: Data?) in
          if let data = data {
            let image = UIImage(data: data)
            XCTAssert(image != nil, "no image in cache.")
          } else {
            XCTAssert(false, "no data from url.")
          }
          expectation.fulfill()
        })
      }
      waitForExpectations(timeout: 60, handler: { _ in
        self.stopMeasuring()
      })
    }
  }
}
