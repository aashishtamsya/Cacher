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
// MARK: - Cache
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
      diskCache.retrieve(key: key, completion)
    case .memory:
      memoryCache.retrieve(key: key, completion)
    case .none:
      completion(nil)
    }
  }
  
  public func removeAll() {
    memoryCache.removeAll()
    taskPool.removeAll()
  }
}
// MARK: - Downloadable
extension Cacher: Downloadable {
  public func download<T>(cacheType type: CacheType, url: URL, completion: @escaping (T?, CacheType) -> Void) -> CancelToken? where T: Cachable {
    guard let key = url.key else {
      completion(nil, .none)
      return nil
    }
    var token: CancelToken?
    switch type {
    case .none:
      return nil
    case .disk:
      diskCache.retrieve(key: key) { [weak self] (object: Data?) in
        token = self?.process(retrievedObject: object, url: url, type: .disk, completion)
      }
    case .memory:
      memoryCache.retrieve(key: key) { [weak self] (object: Data?) in
        token = self?.process(retrievedObject: object, url: url, type: .memory, completion)
      }
    }
    return token
  }
  
  public func cancel(_ url: URL, token: CancelToken? = nil) -> Bool {
    guard let task = token?.task, let cancelToken = taskPool.filter({ $0.key == task && $0.value == url }).first?.key else { return false }
    cancelToken.cancel()
    taskPool.removeValue(forKey: cancelToken)
    return true
  }
}
// MARK: - Private Methods
private extension Cacher {
  func process<T>(retrievedObject object: Data?, url: URL, type: CacheType, _ completion: @escaping (T?, CacheType) -> Void) -> CancelToken? where T: Cachable {
    var token: CancelToken?
    if let data = object {
      completion(data as? T, type)
    } else {
      let task = self.session.dataTask(with: url) { [weak self] data, _, _ in
        self?.storeInCache(CacheSettings(type: type, url: url, object: data, image: nil), completion)
      }
      task.resume()
      let cancelToken = CancelToken(task)
      taskPool[task] = url
      token = cancelToken
    }
    return token
  }
  
  func storeInCache<T>(_ settings: CacheSettings?, _ completion: @escaping (T?, CacheType) -> Void) where T: Cachable {
    guard let data = settings?.object, let key = settings?.url?.key, let type = settings?.type else {
      completion(nil, .none)
      return
    }
    switch type {
    case .disk:
      diskCache.store(key: key, object: data) { completion(data as? T, .none) }
    case .memory:
      memoryCache.store(key: key, object: data) { completion(data as? T, .none) }
    case .none:
      completion(data as? T, .none)
    }
  }
}
