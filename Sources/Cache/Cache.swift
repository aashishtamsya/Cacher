//
//  Cacheable.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public protocol Cache {
  func store<T: Cachable>(key: String, object: T, completion: (() -> Void)?)
  
  func retrieve<T: Cachable>(key: String, completion: @escaping (_ object: T?) -> Void)
}
