//
//  Data+Cache.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

extension Data: Cachable {
  public typealias T = Data

  public static func decode(_ data: Data) -> Data? {
    return data
  }
  
  public func encode() -> Data? {
    return self
  }
}
