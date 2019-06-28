//
//  AlbumPhotoCell.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit
import Cacher

final class AlbumPhotoCell: UITableViewCell {
  // MARK: - Outlets
  @IBOutlet fileprivate weak var photoImageView: UIImageView!
  @IBOutlet fileprivate weak var contentLabel: UILabel!
  @IBOutlet fileprivate weak var albumIdLabel: UILabel!
  @IBOutlet fileprivate weak var photoIdLabel: UILabel!
  // MARK: - Properties
  fileprivate var url: URL?
  fileprivate var cancelToken: CancelToken?
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
extension AlbumPhotoCell {
  func bind(_ albumPhoto: AlbumPhoto?) {
    guard let albumPhoto = albumPhoto, let url = albumPhoto.thumbnailURL else { return }
    let albumId = albumPhoto.albumId?.toString ?? ""
    let photoId = albumPhoto.id?.toString ?? ""
    albumIdLabel.text = !albumId.isEmpty ? ("Album ID : " + albumId) : ""
    photoIdLabel.text = !photoId.isEmpty ? ("Photo ID : " + photoId) : ""
    contentLabel.text = albumPhoto.title
    self.url = url
    cancelToken = photoImageView.loadImage(withURL: url, placeholder: #imageLiteral(resourceName: "ic_pattern_placeholder"), transition: .fade(0.5))
  }
  
  func cancelLoading() {
    guard let url = url, let cancelToken = cancelToken else { return }
    _ = photoImageView.cancelImageLoading(url, cancelToken: cancelToken)
  }
}
// MARK: - Private Methods
private extension AlbumPhotoCell {
  func setup() {
    url = nil
    cancelToken = nil
    photoImageView.image = nil
  }
}
