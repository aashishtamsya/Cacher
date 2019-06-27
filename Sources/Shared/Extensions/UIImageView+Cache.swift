//
//  UIImageView+Cache.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

extension UIImageView {
  public func loadImage(withURL url: URL, placeholder: UIImage? = nil, transition: ImageTransition? = .none, completion: ((UIImage?) -> Void)? = nil) -> RequestToken? {
    let cache = Cacher.sharedCache
    let token = cache.download(cacheType: .memory, url: url) { (object: Data?, cacheType: CacheType) in
      if let data = object, let image = UIImage(data: data) {
        guard self.requiresTransition(transition: transition ?? .none, cacheType: cacheType) else {
          DispatchQueue.main.async {
            self.image = image
            completion?(image)
          }
          return
        }
        if let transition = transition {
          self.performTransition(image: image, transition: transition, done: {
            completion?(image)
          })
        } else {
          DispatchQueue.main.async {
            self.image = image
            completion?(image)
          }
        }
      } else {
        DispatchQueue.main.async {
          self.image = placeholder
          completion?(nil)
        }
      }
    }
    return token
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
  
  public func cancelImageLoading(_ url: URL, cancelToken: RequestToken? = nil) {
    Cacher.sharedCache.cancel(url, token: cancelToken)
  }
}
