//
//  User.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation
import SwiftyJSON

final class User {
  fileprivate var id: String?
  fileprivate var username: String?
  fileprivate var name: String?
  
  fileprivate var profileImage: String?
  var profileImageURL: URL? {
    get {
      guard let profileImage = profileImage, !profileImage.isEmpty else { return nil }
      return URL(string: profileImage)
    }
  }
  
  typealias T = User
}

extension User: Decoder {
  static func decode(json: JSON) -> User {
    let id           = json["id"].string
    let username     = json["username"].string
    let name         = json["name"].string
    let profileImage = json["profile_image"]["small"].string
    
    let user = User()
    user.id           = id
    user.username     = username
    user.name         = name
    user.profileImage = profileImage
    return user
  }
}
