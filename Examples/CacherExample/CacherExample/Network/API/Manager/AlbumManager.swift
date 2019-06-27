//
//  AlbumManager.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 27/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

private enum AlbumParameterType {
  case photos
  
  func apiEndpoint() -> String {
    switch self {
    case .photos:
      return "photos"
    }
  }
  
  func parameters() -> [String: Any] {
    switch self {
    case .photos:
      return [:]
    }
  }
}

private func retrieveAlbumImageDatas<E>(parameterType: AlbumParameterType, type: E.Type, _ callback: @escaping (Result<[E.T]>) -> Void) where E: Decoder {
  HTTPRequestOperationManager(baseUrl: "https://jsonplaceholder.typicode.com", apiEndpoint: parameterType.apiEndpoint()).get { result in
    switch result {
    case .failure(let error):
      callback(.failure(error))
    case .success(let json):
      callback(.success(json.array?.map({ E.decode(json: $0) }) ?? []))
    }
  }
}

func retrieveAlbumImages(_ callback: @escaping (Result<[AlbumPhoto]>) -> Void) {
  retrieveAlbumImageDatas(parameterType: .photos, type: AlbumPhoto.self, callback)
}
