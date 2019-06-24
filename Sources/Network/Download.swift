//
//  Download.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public protocol Download {
  func download<T: Cachable>(url: URL, completion: @escaping (_ object: T?) -> Void)
}
