//
//  UIImageViewExtensionTests.swift
//  CacherTests
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import Cacher

final class UIImageViewExtensionTests: XCTestCase {
  func test_image_download_without_transition() {
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 160, height: 90))
    guard let url = URL(string: "https://images.unsplash.com/photo-1561312176-5aedf7172115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=633&q=80") else {
      XCTAssert(false, "url error")
      return
    }
    let expectation = self.expectation(description: "Download image on UIImageView")
    _ = imageView.loadImage(withURL: url) { image in
      XCTAssert(image != nil, "no image")
      expectation.fulfill()
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
  
  func test_image_download_with_transition() {
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 160, height: 90))
    guard let url = URL(string: "https://images.unsplash.com/photo-1561312176-5aedf7172115?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=633&q=80") else {
      XCTAssert(false, "url error")
      return
    }
    let expectation = self.expectation(description: "Download image on UIImageView")
    _ = imageView.loadImage(withURL: url, transition: .fade(0.5)) { image in
      XCTAssert(image != nil, "no image")
      expectation.fulfill()
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
}
