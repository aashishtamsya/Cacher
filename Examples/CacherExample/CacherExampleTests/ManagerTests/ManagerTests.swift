//
//  ManagerTests.swift
//  CacherExampleTests
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import CacherExample

final class ManagerTests: XCTestCase {
  func test_unsplash_image_retrieving_manager() {
    let expectation = self.expectation(description: "Testing unsplash image retrieving and parsing managers.")
    retrieveUnsplashImages { result in
      switch result {
      case .failure(let error):
        XCTAssert(false, error.errorMessage)
      case .success(let assets):
        XCTAssert(!assets.isEmpty, "No assets parsed.")
      }
      expectation.fulfill()
    }
    waitForExpectations(timeout: 60, handler: nil)
  }
}
