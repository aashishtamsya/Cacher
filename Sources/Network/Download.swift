//
//  Download.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public protocol Download {
  func download<T: Cachable>(cacheType type: CacheType, url: URL, completion: @escaping (_ object: T?, _ cacheType: CacheType) -> Void) -> RequestToken?
  
  func cancel(_ url: URL, token: RequestToken?) -> Bool
}
