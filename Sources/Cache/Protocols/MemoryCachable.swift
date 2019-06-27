//
//  MemoryCachable.swift
//  Cacher
//
//  Created by Aashish Tamsya on 27/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

protocol MemoryCachable {
  func store<T: Cachable>(key: String, object: T, _ completion: (() -> Void)?)
  
  func retrieve<T: Cachable>(key: String, _ completion: @escaping (_ object: T?) -> Void)
  
  func removeAll()

}
