//
//  ImageTransition.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public enum ImageTransition {
  case none
  case fade(TimeInterval)
  
  var duration: TimeInterval {
    switch self {
    case .fade(let duration):
      return duration
    case .none:
      return 0
    }
  }
  
  var animationOptions: UIView.AnimationOptions {
    switch self {
    case .fade: return .transitionCrossDissolve
    case .none: return []
    }
  }
}
