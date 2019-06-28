//
//  CacnelToken.swift
//  Cacher
//
//  Created by Aashish Tamsya on 26/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public class CancelToken: Hashable {
  weak var task: URLSessionDataTask?
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(task.hashValue)
  }
  
  init(_ task: URLSessionDataTask) {
    self.task = task
  }
  
  func cancel() -> Bool {
    guard let task = task else { return false }
    task.cancel()
    return true
  }
}
extension CancelToken: Equatable {
  public static func == (lhs: CancelToken, rhs: CancelToken) -> Bool {
    return lhs.hashValue == rhs.hashValue
  }
}
