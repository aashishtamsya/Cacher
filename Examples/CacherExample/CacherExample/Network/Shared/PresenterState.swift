//
//  PresenterState.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

public enum PresenterState<T> {
  case loading
  case failure(APIError)
  case success(T)
}
