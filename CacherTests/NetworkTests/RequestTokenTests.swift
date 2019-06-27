//
//  RequestTokenTests.swift
//  CacherTests
//
//  Created by Aashish Tamsya on 28/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import Cacher

final class RequestTokenTests: XCTestCase {
  
  func test_requestToken_hashable() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg") else {
      XCTAssert(false, "no image at url")
      return
    }
    let cache = Cacher.sharedCache
    let tokenFirst = cache.download(cacheType: .memory, url: imageURL) { (object: Data?, _) in }
    let tokenSecond = cache.download(cacheType: .memory, url: imageURL) { (object: Data?, _) in }
    XCTAssert(tokenFirst != tokenSecond, "token different")
  }
  
  func test_requestToken_cancel() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg") else {
      XCTAssert(false, "no image at url")
      return
    }
    let cache = Cacher.sharedCache
    let token = cache.download(cacheType: .memory, url: imageURL) { (object: Data?, _) in }
    XCTAssert(token?.cancel() != nil, "request cancelled")
  }
}
