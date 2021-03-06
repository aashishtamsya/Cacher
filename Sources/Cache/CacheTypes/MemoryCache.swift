//
//  MemoryCache.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

final internal class MemoryCache: MemoryCachable {
  private let cache = NSCache<AnyObject, AnyObject>()

  func store<T>(key: String, object: T, _ completion: (() -> Void)?) where T: Cachable {
    cache.setObject(object as AnyObject, forKey: key as AnyObject)
    completion?()
  }
  
  func retrieve<T>(key: String, _ completion: @escaping (T?) -> Void) where T: Cachable {
    let object = cache.object(forKey: key as AnyObject)
    completion(object as? T)
  }

  func removeAll() {
    cache.removeAllObjects()
  }
}
