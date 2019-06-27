//
//  UnsplashManager.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

private enum UnsplashParameterType {
  case list
  
  func apiEndpoint() -> String {
    switch self {
    case .list:
       return "raw/wgkJgazE"
    }
  }
  
  func parameters() -> [String: Any] {
    switch self {
    case .list:
      return [:]
    }
  }
}

private func retrieveUnsplashDatas<E>(parameterType: UnsplashParameterType, type: E.Type, _ callback: @escaping (Result<[E.T]>) -> Void) where E: Decoder {
  HTTPRequestOperationManager(apiEndpoint: parameterType.apiEndpoint()).get { result in
    switch result {
    case .failure(let error):
      callback(.failure(error))
    case .success(let json):
      callback(.success(json.array?.map({ E.decode(json: $0) }) ?? []))
    }
  }
}

func retrieveUnsplashImages(_ callback: @escaping (Result<[Photo]>) -> Void) {
  retrieveUnsplashDatas(parameterType: .list, type: Photo.self, callback)
}
