//
//  UnsplashViewController.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit

final class UnsplashViewController: UIViewController {
  @IBOutlet fileprivate weak var tableView: UITableView!
  
  static func unsplashViewController() -> UnsplashViewController {
    return UIStoryboard(name: "Unsplash", bundle: nil).instantiateViewController(withIdentifier: "UnsplashViewController") as! UnsplashViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "UnsplashTitle".localized
  }

}

extension UnsplashViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
