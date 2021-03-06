//
//  CacheType.swift
//  CacherTests
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public enum CacheType {
  case none
  case memory
  case disk
  
  public var isCached: Bool {
    switch self {
    case .memory, .disk: return true
    case .none: return false
    }
  }
}
