//
//  Cacher.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public class Cacher: Cache {
  public static let sharedCache = Cacher()
  
  let memoryCache = MemoryCache()
  
  public func store<T>(key: String, object: T, completion: (() -> Void)?) where T : Cachable {
    memoryCache.store(key: key, object: object, completion: nil)
  }
  
  public func retrieve<T>(key: String, completion: @escaping (T?) -> Void) where T : Cachable {
    memoryCache.retrieve(key: key) { (object: T?) in
      if let object = object {
        completion(object)
        return
      }
    }
  }
}
