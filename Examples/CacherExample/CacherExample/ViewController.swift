//
//  ViewController.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit
import Cacher

class ViewController: UIViewController {
  @IBOutlet fileprivate weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard let imageURL = URL(string: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)) else { return }
    let cache = Cacher.sharedCache
    cache.store(key: "google", object: image, completion: nil)
    cache.retrieve(key: "google") { [weak self] (image: UIImage?) in
      if let image = image {
        self?.imageView.image = image
      } else {
        print("no image.")
      }
    }
  }
}
