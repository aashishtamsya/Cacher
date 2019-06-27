//
//  Photo.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Photo {
  fileprivate var id: String?
  
  private(set) var color: String?
  var uiColor: UIColor? {
    get {
      guard let color = color, !color.isEmpty, let _color = UIColor(hex: color) else { return nil }
      return _color
    }
  }
  private(set) var width: Int?
  private(set) var height: Int?
  
  private(set) var user: User?
  private(set) var urls: ImageURLs?
  private(set) var likes: Int?
  private(set) var likedByUser = false
  private(set) var createdAt: Date?
  
  
  typealias T = Photo
}

extension Photo: Decoder {
  static func decode(json: JSON) -> Photo {
    let id          = json["id"].string
    let color       = json["color"].string
    let width       = json["width"].int
    let height      = json["height"].int
    let user        = User.decode(json: json["user"])
    let urls        = ImageURLs.decode(json: json["urls"])
    let likes       = json["likes"].int
    let likedByUser = json["liked_by_user"].bool ?? false
    let createdAt   = DateFormatter.cachedFormatterWithFormat(format: apiDateFormat).date(from: json["created_at"].stringValue)

    let asset = Photo()
    asset.id          = id
    asset.color       = color
    asset.width       = width
    asset.height      = height
    asset.user        = user
    asset.urls        = urls
    asset.likes       = likes
    asset.likedByUser = likedByUser
    asset.createdAt   = createdAt
    return asset
  }
}
