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
    remoteImageView.loadImage(withURL: url, placeholder: #imageLiteral(resourceName: "bg_placeholder"), transition: .fade(0.5), completion: { _ in
    })
  }
    
}