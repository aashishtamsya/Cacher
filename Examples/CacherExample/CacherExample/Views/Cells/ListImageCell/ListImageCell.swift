//
//  ListImageCell.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit
import Cacher

final class ListImageCell: UITableViewCell {
  @IBOutlet fileprivate weak var remoteImageView: UIImageView!
  
  
  func bind(_ url: URL?) {
    guard let url = url else { return }
    let cache = Cacher.sharedCache
    cache.download(url: url) { [weak self] (object: Data?) in
      if let data = object, let image = UIImage(data: data) {
        DispatchQueue.main.async {
          self?.remoteImageView.image = image
        }
      }
    }
  }
    
}
