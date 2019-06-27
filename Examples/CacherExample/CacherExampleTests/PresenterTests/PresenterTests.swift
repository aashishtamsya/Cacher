//
//  PresenterTests.swift
//  CacherExampleTests
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import CacherExample

final class PresenterTests: XCTestCase {

  func test_unsplash_image_retrieving_presenter() {
    let expectation = self.expectation(description: "Retrieving assets from Unsplash for ViewController")
    getUnsplashImages { state in
      switch state {
      case .loading:
        print("Loading...")
      case .failure(let error):
        XCTAssert(false, error.errorMessage)
        expectation.fulfill()
      case .success(let assets):
        XCTAssert(!assets.isEmpty, "Unable to retreive assets from Unsplash API.")
        expectation.fulfill()
      }
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
}
