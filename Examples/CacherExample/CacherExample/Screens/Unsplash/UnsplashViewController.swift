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
  @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
  
  fileprivate var dataSource: [Asset]?
  
  static func unsplashViewController() -> UnsplashViewController {
    return UIStoryboard(name: "Unsplash", bundle: nil).instantiateViewController(withIdentifier: "UnsplashViewController") as! UnsplashViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "UnsplashTitle".localized
    tableView.register(UINib(nibName: "ListImageCell", bundle: nil), forCellReuseIdentifier: "ListImageCell")
    fetchImages()
  }
}
// MARK: - UITableViewDataSource
extension UnsplashViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListImageCell") as! ListImageCell
    cell.bind(dataSource?[indexPath.row].urls?.rawURL)
    return cell
  }
}
// MARK: - Private Methods
private extension UnsplashViewController {
  func fetchImages() {
    getUnsplashImagesAsync { [weak self] state in
      switch state {
      case .loading:
        self?.activityIndicator.startAnimating()
      case .failure(let error):
        self?.activityIndicator.stopAnimating()
        print(error.errorMessage)
      case .success(let assets):
        self?.activityIndicator.stopAnimating()
        self?.dataSource = assets
        self?.tableView.reloadData()
      }
    }
  }
}
