//
//  DataExtensionTests.swift
//  CacherTests
//
//  Created by Aashish Tamsya on 28/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import Cacher

final class DataExtensionTests: XCTestCase {
  func test_decoding_ofData_cachable() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let data = try? Data(contentsOf: imageURL) else {
        XCTAssert(false, "no image at url")
        return
    }
    XCTAssert(Data.decode(data) != nil, "Data confirms to Cachable.")
  }
}
