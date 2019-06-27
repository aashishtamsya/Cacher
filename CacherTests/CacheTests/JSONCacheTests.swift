//
//  JSONCacheTests.swift
//  CacherTests
//
//  Created by Aashish Tamsya on 27/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import Cacher

final class JSONCacheTests: XCTestCase {
  func test_jsonURL_caching_toMemory() {
    guard let jsonURL = URL(string: "https://support.oneskyapp.com/hc/en-us/article_attachments/202761627/example_1.json"),
      let key = jsonURL.key,
      let jsonData = try? Data(contentsOf: jsonURL) else {
        XCTAssert(false, "no json file at url")
        return
    }
    let expectation = self.expectation(description: "Testing caching of JSON file from url and retrieving it back from cache.")
    let cache = Cacher.sharedCache
    cache.store(to: .memory, key: key, object: jsonData) {
      cache.retrieve(from: .memory, key: key) { (data: Data?) in
        XCTAssert(data != nil, "no json file data")
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
  
  func test_jsonURL_caching_toDisk() {
    guard let jsonURL = URL(string: "https://support.oneskyapp.com/hc/en-us/article_attachments/202761627/example_1.json"),
      let key = jsonURL.key,
      let jsonData = try? Data(contentsOf: jsonURL) else {
        XCTAssert(false, "no json file at url")
        return
    }
    let expectation = self.expectation(description: "Testing caching of JSON file from url and retrieving it back from cache.")
    let cache = Cacher.sharedCache
    cache.store(to: .disk, key: key, object: jsonData) {
      cache.retrieve(from: .disk, key: key) { (data: Data?) in
        XCTAssert(data != nil, "no json file data")
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
  
  func test_jsonURL_downloading_caching_toDisk() {
    guard let jsonURL = URL(string: "https://support.oneskyapp.com/hc/en-us/article_attachments/202761627/example_1.json"),
      let key = jsonURL.key else {
        XCTAssert(false, "no json file at url")
        return
    }
    let expectation = self.expectation(description: "Testing caching of JSON file from url and retrieving it back from cache.")
    let cache = Cacher.sharedCache
    _ = cache.download(cacheType: .disk, url: jsonURL) { (object: Data?, cacheType) in
      print(cacheType)
      cache.retrieve(from: .disk, key: key) { (data: Data?) in
        print("🔥 retrieved from disk")
        XCTAssert(data != nil, "no json file data")
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
  
}
