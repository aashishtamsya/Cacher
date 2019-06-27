//
//  HTTPOperationManager.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation
import Alamofire
import Reachability
import SwiftyJSON

let scheme = "https"
let host   = "pastebin.com"

var APIBaseURL: String {
  get {
    return scheme + "://" + host
  }
}

final class HTTPRequestOperationManager {
  fileprivate var baseURL: String
  fileprivate var endpoint: String
  fileprivate var reachability: Reachability
  
  init(baseUrl: String? = nil, apiEndpoint: String) {
    endpoint = apiEndpoint
    if let baseUrl = baseUrl {
      baseURL = "\(baseUrl)/\(apiEndpoint)"
    } else {
      baseURL = "\(APIBaseURL)/\(apiEndpoint)"
    }
    reachability = Reachability()!
  }
  static func cancelAllRequests() {
    let sessionManager = Alamofire.SessionManager.default
    sessionManager.session.getAllTasks { (allTasks) in
      if allTasks.count > 0 {
        for task in allTasks {
          task.cancel()
        }
      }
    }
  }
  // MARK: Request
  func get(withParameters parameters: [String: Any] = [:], encoding: ParameterEncoding = URLEncoding(destination: .queryString), callback: @escaping (Result<JSON>) -> Void) {
    processAPICall(withParameters: parameters) { result in
      switch result {
      case .failure(let error):
        callback(.failure(error))
      case .success(let parameters):
        self.performRequest(httpMethod: .get, parameters: parameters, paramEncoding: encoding, callback: callback)
      }
    }
  }
}
// MARK: - Private Methods
private extension HTTPRequestOperationManager {
  func performRequest<T>(_ createAndPerformRequest: @escaping () -> Void, _ callback: @escaping (Result<T>) -> Void) {
    createAndPerformRequest()
  }
  
  func JSONResponseHandler(response: DataResponse<Any>, callback: @escaping (Result<JSON>) -> Void) {
    switch response.result {
    case .success(let value):
      DispatchQueue.main.async {
        callback(.success(JSON(value)))
      }
    case .failure:
      DispatchQueue.main.async {
        if response.response?.statusCode == 401 {
          callback(.failure(APIError(errorType: .noAccess)))
          return
        } else if response.response?.statusCode == 404 {
          callback(.failure(APIError(errorType: .notFound)))
          return
        } else {
          callback(.failure(APIError(errorType: .timeout)))
          return
        }
      }
    }
  }
  
  func processAPICall(withParameters parameters: [String: Any] = [:], callback: @escaping (Result<[String: Any]>) -> Void) {
    if reachability.connection == .none {
      callback(.failure(APIError(errorType: .internetConnectionUnreachable)))
    } else {
      callback(.success(parameters))
    }
  }
  
  func performRequest(httpMethod: HTTPMethod, parameters: [String: Any]? = nil, paramEncoding: ParameterEncoding = URLEncoding(destination: .queryString), customHeaders: [String: String]? = nil, callback: @escaping (Result<JSON>) -> Void) {
    let createAndPerformRequest: () -> Void = {
      DispatchQueue.main.async {
        UIApplication.networkVisibility(animate: true)
      }
      let queue = DispatchQueue(label: UIApplication.bundleIdentifier(), qos: .background, attributes: [.concurrent])
      let manager = Alamofire.SessionManager.default
      manager.session.configuration.timeoutIntervalForRequest = 120
      let request = manager.request("\(self.baseURL)", method: httpMethod, parameters: parameters, encoding: paramEncoding, headers: customHeaders).responseJSON(queue: queue, options: [], completionHandler: { response in
        self.JSONResponseHandler(response: response, callback: callback)
        DispatchQueue.main.async {
          UIApplication.networkVisibility(animate: false)
        }
      })
      debugPrint(request)
    }
    performRequest(createAndPerformRequest, callback)
  }
}
