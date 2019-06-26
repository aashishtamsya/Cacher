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
  // MARK: - Outlets
  @IBOutlet fileprivate weak var remoteImageView: UIImageView!
  // MARK: - Properties
  fileprivate var url: URL?
  fileprivate var cancelToken: RequestToken?
  // MARK: - Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    setup()
  }
}
extension ListImageCell {
  func bind(_ url: URL?) {
    guard let url = url else { return }
    self.url = url
    cancelToken = remoteImageView.loadImage(withURL: url, transition: .fade(0.5))
  }
  
  func cancelLoading() {
    guard let url = url, let cancelToken = cancelToken else { return }
    remoteImageView.cancelImageLoading(url, cancelToken: cancelToken)
  }
}
// MARK: - Private Methods
private extension ListImageCell {
  func setup() {
    url = nil
    cancelToken = nil
    remoteImageView.image = nil
  }
}
