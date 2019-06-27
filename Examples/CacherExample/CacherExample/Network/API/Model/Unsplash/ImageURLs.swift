//
//  ImageURLs.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation
import SwiftyJSON

final class ImageURLs {
  fileprivate var raw: String?
  var rawURL: URL? {
    get {
      guard let raw = raw, !raw.isEmpty else { return nil }
      return URL(string: raw)
    }
  }
  fileprivate var full: String?
  var fullURL: URL? {
    get {
      guard let full = full, !full.isEmpty else { return nil }
      return URL(string: full)
    }
  }
  fileprivate var regular: String?
  var regularURL: URL? {
    get {
      guard let regular = regular, !regular.isEmpty else { return nil }
      return URL(string: regular)
    }
  }
  fileprivate var small: String?
  var smallURL: URL? {
    get {
      guard let small = small, !small.isEmpty else { return nil }
      return URL(string: small)
    }
  }
  fileprivate var thumb: String?
  var thumbURL: URL? {
    get {
      guard let thumb = thumb, !thumb.isEmpty else { return nil }
      return URL(string: thumb)
    }
  }
  typealias T = ImageURLs
}

extension ImageURLs: Decoder {
  static func decode(json: JSON) -> ImageURLs {
    let raw     = json["raw"].string
    let full    = json["full"].string
    let regular = json["regular"].string
    let small   = json["small"].string
    let thumb   = json["thumb"].string

    let assetURLInfo = ImageURLs()
    assetURLInfo.raw     = raw
    assetURLInfo.full    = full
    assetURLInfo.regular = regular
    assetURLInfo.small   = small
    assetURLInfo.thumb   = thumb
    return assetURLInfo
  }
}
