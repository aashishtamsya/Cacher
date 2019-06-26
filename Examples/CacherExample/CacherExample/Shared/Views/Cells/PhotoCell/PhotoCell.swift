//
//  PhotoCell.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 26/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit
import Cacher

final class PhotoCell: UITableViewCell {
  @IBOutlet fileprivate weak var profileImageView: UIImageView!
  @IBOutlet fileprivate weak var nameLabel: UILabel!
  @IBOutlet fileprivate weak var usernameLabel: UILabel!
  @IBOutlet fileprivate weak var timeLabel: UILabel!
  
  @IBOutlet fileprivate weak var photoImageView: UIImageView!
  @IBOutlet fileprivate weak var likeImageView: UIImageView!
  @IBOutlet fileprivate weak var likeCountLabel: UILabel!
  
  fileprivate var profileCancelToken: RequestToken?
  fileprivate var photoCancelToken: RequestToken?
  fileprivate var photoURL: URL?
  fileprivate var profileURL: URL?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    setup()
  }
}
// MARK: - Binding Methods
extension PhotoCell {
  func bind(_ photo: Photo?) {
    photoURL = photo?.urls?.fullURL
    profileURL = photo?.user?.profileImage?.mediumURL
    guard let photo = photo else { return }
    if let url = photo.user?.profileImage?.mediumURL {
      profileCancelToken = profileImageView.loadImage(withURL: url, transition: .fade(0.5))
    }
    if let url = photo.urls?.fullURL {
      photoCancelToken = photoImageView.loadImage(withURL: url, transition: .fade(0.5))
    }
    nameLabel.text = photo.user?.name
    usernameLabel.text = photo.user?.handler
    likeCountLabel.text = photo.likes?.toLikeString ?? ""
    likeImageView.image = photo.likedByUser ? #imageLiteral(resourceName: "ic_liked") : #imageLiteral(resourceName: "ic_like")
    timeLabel.text = photo.createdAt?.friendlyDateString
  }
  
  func cancelImageLoading() {
    if let photoURL = photoURL, let photoCancelToken = photoCancelToken {
      photoImageView.cancelImageLoading(photoURL, cancelToken: photoCancelToken)
    }
    if let profileURL = profileURL, let profileCancelToken = profileCancelToken {
      profileImageView.cancelImageLoading(profileURL, cancelToken: profileCancelToken)
    }
  }
}
// MARK: - Private Methods
private extension PhotoCell {
  func setup() {
    photoURL                = nil
    photoCancelToken        = nil
    profileURL              = nil
    profileCancelToken      = nil
    profileImageView.image  = nil
    photoImageView.image    = nil
    likeImageView.image     = #imageLiteral(resourceName: "ic_like")
    likeImageView.tintColor = .gray
    profileImageView.roundCorners()
  }
}
