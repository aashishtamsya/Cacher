//
//  DiskCache.swift
//  Cacher
//
//  Created by Aashish Tamsya on 27/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

final internal class DiskCache: DiskCachable {
  
  public let path: String = {
    let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    return (destinationPath as NSString).appendingPathComponent("CacherDiskCache")
  }()
  
  fileprivate let fileManager = FileManager()
  fileprivate let ioQueue: DispatchQueue = DispatchQueue(label: "CacherDiskCacheIOQueue")
  
  func store<T>(key: String, object: T, _ completion: (() -> Void)?) where T: Cachable {
    ioQueue.async {
      if !self.fileManager.fileExists(atPath: self.path) {
        do {
          try self.fileManager.createDirectory(atPath: self.path, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
          
        }
      }
      
      let cacheFilePath = (self.path as NSString).appendingPathComponent(key)
      self.fileManager.createFile(atPath: cacheFilePath, contents: object.encode(), attributes: nil)
      completion?()
    }
  }
  
  func retrieve<T>(key: String, _ completion: @escaping (T?) -> Void) where T: Cachable {
    let filePath = (self.path as NSString).appendingPathComponent(key)
    let object = try? Data(contentsOf: URL(fileURLWithPath: filePath))
    completion(object as? T)
  }
}
