//
//  UIImage+Cache.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit

extension UIImage: Cachable {
  public typealias T = UIImage
  
  public static func decode(_ data: Data) -> UIImage? {
    let image = UIImage(data: data)
    return image
  }
  
  public func encode() -> Data? {
    return hasAlpha ? pngData() : jpegData(compressionQuality: 1.0)
  }
}

extension UIImage {
  var hasAlpha: Bool {
    var result = false
    guard let alpha = cgImage?.alphaInfo else { return false }
    switch alpha {
    case .none, .noneSkipLast, .noneSkipFirst:
      result = false
    case .premultipliedLast, .premultipliedFirst, .last, .first, .alphaOnly:
      result = true
    @unknown default:
      result = false
    }
    return result
  }
}
