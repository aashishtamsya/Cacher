//
//  MultipleImageViewController.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 26/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import UIKit
import Cacher

final class MultipleImageViewController: UIViewController {
  @IBOutlet fileprivate weak var oneImageView: UIImageView!
  @IBOutlet fileprivate weak var twoImageView: UIImageView!
  @IBOutlet fileprivate weak var threeImageView: UIImageView!
  @IBOutlet fileprivate weak var firstActivityIndicator: UIActivityIndicatorView!
  @IBOutlet fileprivate weak var secondActivityIndicator: UIActivityIndicatorView!
  @IBOutlet fileprivate weak var thirdActivityIndicator: UIActivityIndicatorView!
  
  fileprivate var url: URL? {
    get {
      guard let url = URL(string: "https://images.unsplash.com/photo-1489249902199-9d713a2c68b5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80") else { return nil }
      return url
    }
  }
  fileprivate var oneRequestToken: RequestToken?
  fileprivate var twoRequestToken: RequestToken?
  fileprivate var threeRequestToken: RequestToken?

  
  static func MultipleImageViewController() -> MultipleImageViewController {
    return UIStoryboard(name: "MultipleImage", bundle: nil).instantiateViewController(withIdentifier: "MultipleImageViewController") as! MultipleImageViewController
  }
  
}
// MARK: - Actions
private extension MultipleImageViewController {
  @IBAction func downloadAllButtonSelected(_ sender: UIButton) {
    guard let url = url else { return }
    firstActivityIndicator.startAnimating()
    oneRequestToken = oneImageView.loadImage(withURL: url, transition: .fade(0.5)) { [weak self] _ in
      DispatchQueue.main.async {
        self?.firstActivityIndicator.stopAnimating()
      }
    }
    secondActivityIndicator.startAnimating()
    twoRequestToken = twoImageView.loadImage(withURL: url, transition: .fade(0.5)) { [weak self] _ in
      DispatchQueue.main.async {
        self?.secondActivityIndicator.stopAnimating()
      }
    }
    thirdActivityIndicator.startAnimating()
    threeRequestToken = threeImageView.loadImage(withURL: url, transition: .fade(0.5)) { [weak self] _ in
      DispatchQueue.main.async {
        self?.thirdActivityIndicator.stopAnimating()
      }
    }
  }
  @IBAction func oneCancelButtonSelected(_ sender: UIButton) {
    guard let url = url, let oneRequestToken = oneRequestToken else { return }
    firstActivityIndicator.stopAnimating()
    _ = oneImageView.cancelImageLoading(url, cancelToken: oneRequestToken)
  }
  @IBAction func twoCancelButtonSelected(_ sender: UIButton) {
    guard let url = url, let twoRequestToken = twoRequestToken else { return }
    secondActivityIndicator.stopAnimating()
    _ = twoImageView.cancelImageLoading(url, cancelToken: twoRequestToken)
  }
  @IBAction func threeCancelButtonSelected(_ sender: UIButton) {
    guard let url = url, let threeRequestToken = threeRequestToken else { return }
    thirdActivityIndicator.stopAnimating()
    _ = threeImageView.cancelImageLoading(url, cancelToken: threeRequestToken)
  }
}
