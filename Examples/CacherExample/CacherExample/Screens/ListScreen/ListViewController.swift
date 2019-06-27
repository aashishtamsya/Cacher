//
//  ListViewController.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
  @IBOutlet fileprivate weak var tableView: UITableView!
  @IBOutlet fileprivate weak var activityIndicator: UIActivityIndicatorView!
  
  fileprivate var datasource: [AlbumPhoto]?

  static func listViewController() -> ListViewController {
    return UIStoryboard(name: "List", bundle: nil).instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "5000ImagesTitle".localized
    tableView.register(UINib(nibName: "AlbumPhotoCell", bundle: nil), forCellReuseIdentifier: "AlbumPhotoCell")
    fetchAlbumPhotos()

  }
}

private extension ListViewController {
  func fetchAlbumPhotos(showActivityIndicator: Bool = false) {
    if showActivityIndicator {
      activityIndicator.startAnimating()
    }
    getAlbumImages { [weak self] state in
      switch state {
      case .loading:
        self?.activityIndicator.startAnimating()
      case .failure(let error):
        self?.activityIndicator.stopAnimating()
        print(error.errorMessage)
      case .success(let photos):
        self?.activityIndicator.stopAnimating()
        self?.datasource = photos
        self?.tableView.reloadData()
      }
    }
  }
}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return datasource?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumPhotoCell") as! AlbumPhotoCell
    cell.bind(datasource?[indexPath.row])
    return cell
  }
}

extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? AlbumPhotoCell else { return }
    cell.cancelLoading()
  }
}
