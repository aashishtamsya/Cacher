//
//  UIImageView+Extensions.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

extension UIImageView {
  public func loadImage(withURL url: URL, placeholder: UIImage? = nil, transition: ImageTransition? = .none, completion: @escaping (UIImage?) -> Void) {
    let cache = Cacher.sharedCache
    cache.download(url: url) { (object: Data?, cacheType: CacheType) in
      if let data = object, let image = UIImage(data: data) {
        guard self.requiresTransition(transition: transition ?? .none, cacheType: cacheType) else {
          DispatchQueue.main.async {
            self.image = image
            completion(image)
          }
          return
        }
        if let transition = transition {
          self.performTransition(image: image, transition: transition, done: {
            completion(image)
          })
        } else {
          DispatchQueue.main.async {
            self.image = image
            completion(image)
          }
        }
      } else {
        DispatchQueue.main.async {
          self.image = placeholder
          completion(nil)
        }
      }
    }
  }
  
  private func requiresTransition(transition: ImageTransition, cacheType: CacheType) -> Bool {
    switch transition {
    case .none:
      return false
    case .fade:
      if cacheType == .none { return true }
      return false
    }
  }
  
  private func performTransition(image: UIImage, transition: ImageTransition, done: @escaping () -> Void) {
    UIView.transition(with: self, duration: transition.duration, options: [transition.animationOptions, .allowUserInteraction], animations: {
      DispatchQueue.main.async {
        self.image = image
      }
    }, completion: { _ in
      DispatchQueue.main.async {
        done()
      }
    })
  }
}
