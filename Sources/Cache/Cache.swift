//
//  Cacheable.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public protocol Cache {
  func store<T: Cachable>(key: String, object: T, _ completion: (() -> Void)?)
  
  func retrieve<T: Cachable>(key: String, _ completion: @escaping (_ object: T?) -> Void)
  
  func removeAll()
}
