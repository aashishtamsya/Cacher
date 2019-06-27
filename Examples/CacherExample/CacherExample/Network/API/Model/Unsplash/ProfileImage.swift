//
//  ProfileImage.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 26/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation
import SwiftyJSON

final class ProfileImage {
  fileprivate var small: String?
  fileprivate var medium: String?
  fileprivate var large: String?
  
  var smallURL: URL? {
    get {
      guard let small = small, !small.isEmpty else { return nil }
      return URL(string: small)
    }
  }
  var mediumURL: URL? {
    get {
      guard let medium = medium, !medium.isEmpty else { return nil }
      return URL(string: medium)
    }
  }
  var largeURL: URL? {
    get {
      guard let large = large, !large.isEmpty else { return nil }
      return URL(string: large)
    }
  }
  
  typealias T = ProfileImage
}

extension ProfileImage: Decoder {
  static func decode(json: JSON) -> ProfileImage {
    let small = json["small"].string
    let medium = json["medium"].string
    let large = json["large"].string
    
    let profileImage = ProfileImage()
    profileImage.small  = small
    profileImage.large  = large
    profileImage.medium = medium
    return profileImage
  }
}
