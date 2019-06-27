//
//  JSONViewController.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 27/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit
import Cacher

final class JSONViewController: UIViewController {
  @IBOutlet weak var contentLabel: UILabel!
  
  fileprivate var jsonURL: URL? {
    get {
      guard let url = URL(string: "https://support.oneskyapp.com/hc/en-us/article_attachments/202761627/example_1.json") else { return nil }
      return url
    }
  }
  
  static func jsonViewController() -> JSONViewController {
    return UIStoryboard(name: "JSONExample", bundle: nil).instantiateViewController(withIdentifier: "JSONViewController") as! JSONViewController
  }
}
// MARK: - @IBActions
private extension JSONViewController {
  @IBAction func downloadButtonSelected(_ sender: UIButton) {
    guard let url = jsonURL else { return }
    let cache = Cacher.sharedCache
    _ = cache.download(url: url) { [weak self] (object: Data?, cacheType)  in
      cache.retrieve(key: url.absoluteString) { [weak self] (cachedData: Data?) in
        if let data = cachedData, let contents = String(data: data, encoding: .utf8) {
          DispatchQueue.main.async {
            self?.contentLabel.text = contents
          }
        }
      }
    }
  }
}

