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
  
  fileprivate var dataSource: [Photo]?
  fileprivate var refreshControl = UIRefreshControl()
  
  static func unsplashViewController() -> UnsplashViewController {
    return UIStoryboard(name: "Unsplash", bundle: nil).instantiateViewController(withIdentifier: "UnsplashViewController") as! UnsplashViewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "UnsplashTitle".localized
    tableView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "PhotoCell")
    refreshControl.addTarget(self, action: #selector(UnsplashViewController.refresh), for: .valueChanged)
    tableView.addSubview(refreshControl)
    fetchImages(showActivityIndicator: dataSource == nil)
  }
}
// MARK: - Selectors
private extension UnsplashViewController {
  @objc func refresh() {
    dataSource = nil
    refreshControl.beginRefreshing()
    tableView.reloadData()
    activityIndicator.startAnimating()
    fetchImages(showActivityIndicator: dataSource == nil)
  }
}
// MARK: - UITableViewDataSource
extension UnsplashViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
    cell.bind(dataSource?[indexPath.row])
    return cell
  }
}
extension UnsplashViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? PhotoCell else { return }
    cell.cancelImageLoading()
  }
}
// MARK: - Private Methods
private extension UnsplashViewController {
  func fetchImages(showActivityIndicator: Bool = false) {
    if showActivityIndicator {
      activityIndicator.startAnimating()
    }
    getUnsplashImagesAsync { [weak self] state in
      switch state {
      case .loading:
        self?.activityIndicator.startAnimating()
      case .failure(let error):
        self?.refreshControl.endRefreshing()
        self?.activityIndicator.stopAnimating()
        print(error.errorMessage)
      case .success(let assets):
        self?.refreshControl.endRefreshing()
        self?.activityIndicator.stopAnimating()
        self?.dataSource = assets
        self?.tableView.reloadData()
      }
    }
  }
}
