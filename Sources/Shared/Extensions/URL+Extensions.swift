//
//  URL+Extensions.swift
//  Cacher
//
//  Created by Aashish Tamsya on 27/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

extension URL {
  public var key: String? { get { return pathComponents.last } }
}
