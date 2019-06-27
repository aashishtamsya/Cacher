//
//  AlbumPresenter.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 27/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

func getAlbumImages(_ callback: @escaping (PresenterState<[AlbumPhoto]>) -> Void) {
  callback(.loading)
  retrieveAlbumImages { result in
    switch result {
    case .failure(let error):
      callback(.failure(error))
    case .success(let photos):
      callback(.success(photos))
    }
  }
}
