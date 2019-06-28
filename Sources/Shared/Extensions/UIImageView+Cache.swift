//
//  UIImageView+Cache.swift
//  Cacher
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

extension UIImageView {
  public func loadImage(withURL url: URL, placeholder: UIImage? = nil, transition: ImageTransition? = .none, completion: ((UIImage?) -> Void)? = nil) -> CancelToken? {
    let token = Cacher.sharedCache.download(cacheType: .memory, url: url) { [weak self] (object: Data?, cacheType: CacheType) in
      guard let data = object, let image = UIImage(data: data) else {
        self?.set(placeholder, completion)
        return
      }
      guard let strongSelf = self, strongSelf.requiresTransition(transition: transition ?? .none, cacheType: cacheType) else {
        self?.set(image, completion)
        return
      }
      if let transition = transition {
        self?.performTransition(image: image, transition: transition, done: {
          completion?(image)
        })
      } else {
        self?.set(image, completion)
      }
    }
    return token
  }
  
  private func set(_ image: UIImage?, _ completion: ((UIImage?) -> Void)? = nil) {
    DispatchQueue.main.async {
      self.image = image
      completion?(image)
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
  
  public func cancelImageLoading(_ url: URL, cancelToken: CancelToken? = nil) -> Bool {
    return Cacher.sharedCache.cancel(url, token: cancelToken)
  }
}
