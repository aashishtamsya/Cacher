//
//  Decoder.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Decoder: class {
  associatedtype T
  
  static func decode(json: JSON) -> T
}
