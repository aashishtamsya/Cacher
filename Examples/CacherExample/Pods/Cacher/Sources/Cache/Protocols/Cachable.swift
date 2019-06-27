//
//  Cachable.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public protocol Cachable {
  associatedtype T
  
  static func decode(_ data: Data) -> T?
  
  func encode() -> Data?
  
}
