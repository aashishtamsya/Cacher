//
//  UIApplication+Extensions.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit

extension UIApplication {
  class func networkVisibility(animate: Bool) {
    DispatchQueue.main.async {
      UIApplication.shared.isNetworkActivityIndicatorVisible = animate
    }
  }
  
  class func bundleIdentifier() -> String {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String ?? "com.aashishtamsya.ios.CacherExample"
  }
}
