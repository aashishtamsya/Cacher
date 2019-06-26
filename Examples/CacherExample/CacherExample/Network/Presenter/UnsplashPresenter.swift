//
//  UnsplashPresenter.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

func getUnsplashImages(_ callback: @escaping (PresenterState<[Photo]>) -> Void) {
  callback(.loading)
  retrieveUnsplashImages { result in
    switch result {
    case .failure(let error):
      callback(.failure(error))
    case .success(let assets):
      callback(.success(assets))
    }
  }
}


func getUnsplashImagesAsync(_ callback: @escaping (PresenterState<[Photo]>) -> Void) {
  DispatchQueue.global(qos: .background).async {
    DispatchQueue.main.async {
      callback(.loading)
    }
    retrieveUnsplashImages { result in
      switch result {
      case .failure(let error):
        DispatchQueue.main.async {
          callback(.failure(error))
        }
      case .success(let assets):
        DispatchQueue.main.async {
          callback(.success(assets))
        }
      }
    }
  }
}
