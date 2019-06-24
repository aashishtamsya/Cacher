//
//  Downloader.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public class Downloader {
  public static let shared = Downloader()
  let memoryCache = MemoryCache()
  
}

extension Downloader: Download {
  public func download<T>(url: URL, completion: @escaping (T?) -> Void) where T: Cachable {
    memoryCache.retrieve(key: url.absoluteString) { (object: Data?) in
      if let data = object {
        completion(data as? T)
        return
      } else {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
          guard let strongSelf = self else {
            completion(nil)
            return
          }
          if let data = data {
            strongSelf.memoryCache.store(key: url.absoluteString, object: data, completion: nil)
            completion(data as? T)
          } else {
            completion(nil)
          }
          }.resume()
      }
    }
  }
}
