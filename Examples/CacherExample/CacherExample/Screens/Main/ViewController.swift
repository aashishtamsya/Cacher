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
  @IBOutlet fileprivate weak var downloadActivityIndicator: UIActivityIndicatorView!
  @IBOutlet fileprivate weak var imageView: UIImageView!
  @IBOutlet fileprivate weak var downloadImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadImageFromCache()
  }
}
// MARK: - Private Methods
private extension ViewController {
  func loadImageFromCache() {
    guard let imageURL = URL(string: "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"),
      let image = try? UIImage(data: Data(contentsOf: imageURL)) else { return }
    let cache = Cacher.sharedCache
    cache.store(to: .memory, key: "google", object: image, nil)
    cache.retrieve(from: .memory, key: "google") { [weak self] (image: UIImage?) in
      if let image = image {
        self?.imageView.image = image
      } else {
        print("no image.")
      }
    }
  }
}
// MARK: - Actions
private extension ViewController {
  @IBAction func downloadButtonSelected(_ sender: UIButton) {
    guard let url = URL(string: "https://cdn.pixabay.com/photo/2018/06/11/17/02/flower-3468846_960_720.jpg") else { return }
    downloadActivityIndicator.startAnimating()
    _ = downloadImageView.loadImage(withURL: url, transition: .fade(0.5)) { [weak self] _ in
      DispatchQueue.main.async {
        self?.downloadActivityIndicator.stopAnimating()
      }
    }
  }
  
  @IBAction func cancelButtonSelected(_ sender: UIButton) {
    guard let url = URL(string: "https://cdn.pixabay.com/photo/2018/06/11/17/02/flower-3468846_960_720.jpg") else { return }
    _ = downloadImageView.cancelImageLoading(url)
    downloadActivityIndicator.stopAnimating()
  }
  
  @IBAction func listViewButtonSelected(_ sender: UIButton) {
    navigationController?.pushViewController(ListViewController.listViewController(), animated: true)
  }
  
  @IBAction func unsplashButtonSelected(_ sender: UIButton) {
    navigationController?.pushViewController(UnsplashViewController.unsplashViewController(), animated: true)
  }
  @IBAction func multipleImageButtonSelected(_ sender: UIButton) {
    navigationController?.pushViewController(MultipleImageViewController.MultipleImageViewController(), animated: true)
  }
  @IBAction func clearAllCacheButtonSelected(_ sender: UIButton) {
    Cacher.sharedCache.removeAll()
  }
  @IBAction func jsonFileButtonSelected(_ sender: UIButton) {
    navigationController?.pushViewController(JSONViewController.jsonViewController(), animated: true)
  }
}
