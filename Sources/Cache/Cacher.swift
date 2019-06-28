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
  
  private let memoryCache = MemoryCache()
  private let diskCache = DiskCache()
  private var session: URLSession
  
  init() {
    session = URLSession(configuration: .default)
  }
}

extension Cacher: Cache {
  public func store<T>(to: CacheType, key: String, object: T, _ completion: (() -> Void)?) where T: Cachable {
    switch to {
    case .disk:
      diskCache.store(key: key, object: object, completion)
    case .memory:
      memoryCache.store(key: key, object: object, completion)
    case .none:
      completion?()
    }
  }
  
  public func retrieve<T>(from: CacheType, key: String, _ completion: @escaping (T?) -> Void) where T: Cachable {
    switch from {
    case .disk:
      diskCache.retrieve(key: key) { (object: T?) in
        if let object = object {
          completion(object)
          return
        } else {
          completion(nil)
          return
        }
      }

    case .memory:
      memoryCache.retrieve(key: key) { (object: T?) in
        if let object = object {
          completion(object)
          return
        } else {
          completion(nil)
          return
        }
      }
    case .none:
      completion(nil)
    }
  }
  
  public func removeAll() {
    memoryCache.removeAll()
  }
}

extension Cacher: Download {
  public func download<T>(cacheType type: CacheType, url: URL, completion: @escaping (T?, CacheType) -> Void) -> RequestToken? where T: Cachable {
    guard let key = url.key else {
      completion(nil, .none)
      return nil
    }
    var token: RequestToken?
    switch type {
    case .none:
      return nil
    case .disk:
      diskCache.retrieve(key: key) { [weak self] (object: Data?) in
        token = self?.process(object: object, url: url, type: .disk, completion)
      }
    case .memory:
      memoryCache.retrieve(key: key) { [weak self] (object: Data?) in
        token = self?.process(object: object, url: url, type: .memory, completion)
      }
    }
    return token
  }
  
  public func cancel(_ url: URL, token: RequestToken? = nil) -> Bool {
    guard let task = token?.task, let cancelToken = taskPool.filter({ $0.key == task && $0.value == url }).first?.key else { return false }
    cancelToken.cancel()
    taskPool.removeValue(forKey: cancelToken)
    return true
  }
}

private extension Cacher {
  func process<T>(object: Data?, url: URL, type: CacheType, _ completion: @escaping (T?, CacheType) -> Void) -> RequestToken? where T: Cachable {
    var token: RequestToken?
    if let data = object {
      completion(data as? T, .disk)
    } else {
      let task = self.session.dataTask(with: url) { [weak self] data, _, _ in
        self?.store(data, on: type, key: url.absoluteString, completion)
      }
      task.resume()
      let requestToken = RequestToken(task)
      taskPool[task] = url
      token = requestToken
    }
    return token
  }
  
  func store<T>(_ object: Data?, on type: CacheType, key: String, _ completion: @escaping (T?, CacheType) -> Void) where T: Cachable {
    guard let data = object else {
      completion(nil, .none)
      return
    }
    switch type {
    case .disk:
      diskCache.store(key: key, object: data) {
        completion(data as? T, .none)
      }
    case .memory:
      memoryCache.store(key: key, object: data) {
        completion(data as? T, .none)
      }
    case .none:
      completion(data as? T, .none)
    }
  }
}
