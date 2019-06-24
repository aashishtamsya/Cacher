//
//  Cacher.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public class Cacher {
  public static let sharedCache = Cacher()
  
  let memoryCache = MemoryCache()
  
}

extension Cacher: Cache {
  public func store<T>(key: String, object: T, completion: (() -> Void)?) where T: Cachable {
    memoryCache.store(key: key, object: object, completion: nil)
  }
  
  public func retrieve<T>(key: String, completion: @escaping (T?) -> Void) where T: Cachable {
    memoryCache.retrieve(key: key) { (object: T?) in
      if let object = object {
        completion(object)
        return
      } else {
        completion(nil)
        return
      }
    }
  }
}

extension Cacher: Download {
  public func download<T>(url: URL, completion: @escaping (T?, CacheType) -> Void) where T: Cachable {
    memoryCache.retrieve(key: url.absoluteString) { (object: Data?) in
      if let data = object {
        completion(data as? T, .memory)
        return
      } else {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
          guard let strongSelf = self else {
            completion(nil, .none)
            return
          }
          if let data = data {
            strongSelf.memoryCache.store(key: url.absoluteString, object: data, completion: nil)
            completion(data as? T, .none)
          } else {
            completion(nil, .none)
          }
          }.resume()
      }
    }
  }
}
