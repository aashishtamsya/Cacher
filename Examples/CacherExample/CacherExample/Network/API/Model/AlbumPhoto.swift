//
//  Album.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 27/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation
import SwiftyJSON

final class AlbumPhoto {
  private(set) var albumId: Int?
  private(set)  var id: Int?
  private(set)  var title: String?
  fileprivate var url: String?
  var imageURL: URL? {
    get {
      guard let url = url, !url.isEmpty else { return nil }
      return URL(string: url)
    }
  }
  fileprivate var thumbnailUrl: String?
  var thumbnailURL: URL? {
    get {
      guard let thumbnailUrl = thumbnailUrl, !thumbnailUrl.isEmpty else { return nil }
      return URL(string: thumbnailUrl)
    }
  }
  typealias T = AlbumPhoto
}

extension AlbumPhoto: Decoder {
  static func decode(json: JSON) -> AlbumPhoto {
    let albumId      = json["albumId"].int
    let id           = json["albumId"].int
    let title        = json["title"].string
    let url          = json["url"].string
    let thumbnailUrl = json["thumbnailUrl"].string

    let albumPhoto = AlbumPhoto()
    albumPhoto.albumId      = albumId
    albumPhoto.id           = id
    albumPhoto.title        = title
    albumPhoto.url          = url
    albumPhoto.thumbnailUrl = thumbnailUrl
    return albumPhoto
  }
}
