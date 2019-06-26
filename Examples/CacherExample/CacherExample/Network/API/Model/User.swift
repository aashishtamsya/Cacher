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
  var handler: String? {
    get {
      guard let username = username, !username.isEmpty else { return nil }
      return "@" + username
    }
  }
  private(set) var name: String?
  
  private(set) var profileImage: ProfileImage?
  
  typealias T = User
}

extension User: Decoder {
  static func decode(json: JSON) -> User {
    let id           = json["id"].string
    let username     = json["username"].string
    let name         = json["name"].string
    let profileImage = ProfileImage.decode(json: json["profile_image"])
    
    let user = User()
    user.id           = id
    user.username     = username
    user.name         = name
    user.profileImage = profileImage
    return user
  }
}
