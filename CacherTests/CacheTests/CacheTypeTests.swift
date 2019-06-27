//
//  CacheTypeTests.swift
//  CacherTests
//
//  Created by Aashish Tamsya on 27/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import XCTest
@testable import Cacher

final class CacheTypeTests: XCTestCase {
  func test_cacheType_forDisk() {
    XCTAssert(CacheType.disk.isCached == true, "Disk type")
  }
  
  func test_cacheType_forMemory() {
    XCTAssert(CacheType.memory.isCached == true, "Disk type")
  }
}
