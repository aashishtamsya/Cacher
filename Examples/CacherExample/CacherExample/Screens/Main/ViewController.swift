//
//  ViewController.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit
import Cacher

final class ViewController: UIViewController {
  @IBOutlet fileprivate weak var imageView: UIImageView!
  @IBOutlet fileprivate weak var downloadImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadImageFromCache()
    
  }
}

private extension ViewController {
  func loadImageFromCache() {
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
  
  func loadImage(fromURL url: URL) {
    let cache = Cacher.sharedCache
    cache.download(url: url) { [weak self] (object: Data?, _) in
      if let data = object, let image = UIImage(data: data) {
        DispatchQueue.main.async {
          self?.downloadImageView.image = image
        }
      }
    }
  }
}
// MARK: - Actions
private extension ViewController {
  @IBAction func downloadButtonSelected(_ sender: UIButton) {
    if let url = URL(string: "https://cdn.pixabay.com/photo/2018/06/11/17/02/flower-3468846_960_720.jpg") {
      loadImage(fromURL: url)
    }
  }
  @IBAction func listViewButtonSelected(_ sender: UIButton) {
    navigationController?.pushViewController(ListViewController.listViewController(), animated: true)
  }
}
