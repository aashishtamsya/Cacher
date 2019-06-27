//
//  UIImageExtensionTests.swift
//  CacherTests
//
//  Created by Aashish Tamsya on 28/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import Cacher

final class UIImageExtensionTests: XCTestCase {

  func test_image_decodeable() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let data = try? Data(contentsOf: imageURL) else {
        XCTAssert(false, "no image at url")
        return
    }
    XCTAssert(UIImage.decode(data) != nil, "UIImage doesn't confirm to Cachable.")
  }
  
  func test_image_encode() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)) else {
        XCTAssert(false, "no image at url")
        return
    }
    XCTAssert(image.encode() != nil, "UIImage doesn't confirm to Cachable.")
  }
  
  func test_png_image_hasAlpha() {
    guard let imageURL = URL(string: "http://pluspng.com/img-png/google-logo-png-google-logo-icon-png-transparent-background-1000.png"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)) else {
        XCTAssert(false, "no image at url")
        return
    }
    XCTAssert(image.hasAlpha, "Image doesn't has alpha component.")
  }
  
  func test_jpg_image_hasAlpha() {
    guard let imageURL = URL(string: "http://s75.mindvalley.us/mindvalleyacademy/media/images/teaser-video-cover.jpg"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)) else {
        XCTAssert(false, "no image at url")
        return
    }
    XCTAssert(!image.hasAlpha, "Image doesn't has alpha component.")
  }
}
