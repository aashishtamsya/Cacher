//
//  Int+Extensions.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 26/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

extension Int {
  var toLikeString: String {
    get {
      if self <= 0 { return "" }
      return "\(self)"
    }
  }
  
  var toString: String { get { return "\(self)"} }
}
