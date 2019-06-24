//
//  Asset.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Asset {
  var id: String?
  var width: Int?
  var height: Int?
  
  var user: User?
  var urls: AssetURLInfo?
  
  typealias T = Asset
}

extension Asset: Decoder {
  static func decode(json: JSON) -> Asset {
    let id     = json["id"].string
    let width  = json["width"].int
    let height = json["height"].int
    let user   = User.decode(json: json["user"])
    let urls   = AssetURLInfo.decode(json: json["urls"])
    
    let asset = Asset()
    asset.id     = id
    asset.width  = width
    asset.height = height
    asset.user   = user
    asset.urls   = urls
    return asset
  }
}
