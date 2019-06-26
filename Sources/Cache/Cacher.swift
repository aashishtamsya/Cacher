//
//  Cacher.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

private var taskPool: [URLSessionDataTask: URL] = [:]

public class Cacher {
  public static let sharedCache = Cacher()
  
  let memoryCache = MemoryCache()
  private var session: URLSession
  
  init() {
    session = URLSession(configuration: .default)
  }
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
  public func download<T>(url: URL, completion: @escaping (T?, CacheType) -> Void) -> RequestToken? where T: Cachable {
    var token: RequestToken?
    memoryCache.retrieve(key: url.absoluteString) { (object: Data?) in
      if let data = object {
        completion(data as? T, .memory)
      } else {
        let task = self.session.dataTask(with: url) { [weak self] data, _, _ in
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
        }
        task.resume()
        let requestToken = RequestToken(task)
        taskPool[task] = url
        token = requestToken
      }
    }
    return token
  }
  
  public func cancel(_ url: URL, token: RequestToken? = nil) {
    guard let task = token?.task, let cancelToken = taskPool.filter({ $0.key == task && $0.value == url }).first?.key else { return }
    cancelToken.cancel()
    taskPool.removeValue(forKey: cancelToken)
  }
}

