//
//  APIError.swift
//  CacherExample
//
//  Created by Aashish Tamsya on 24/06/19.
//  Copyright © 2019 Aashish Tamsya. All rights reserved.
//

import Foundation

final public class APIError {
  public enum APIErrorType {
    case network
    case internetConnectionUnreachable
    case unexpectedResponse
    case unsuccessfulRequest
    case requestCancelled
    case unauthorizedAccess
    case serverError
    case loginError
    case other
    case timeout
    case noAccess
    case notFound
    
    func errorMessage() -> String {
      switch self {
      case .network:
        return NSLocalizedString("NetworkError", comment: "")
      case .internetConnectionUnreachable:
        return NSLocalizedString("InternetConnectionError", comment: "")
      case .unexpectedResponse, .unsuccessfulRequest, .requestCancelled:
        return NSLocalizedString("UnexpectedError", comment: "")
      case .unauthorizedAccess:
        return NSLocalizedString("UnauthorizedAccess", comment: "")
      case .serverError:
        return NSLocalizedString("ServerError", comment: "")
      case .loginError:
        return NSLocalizedString("LoginError", comment: "")
      case .other:
        return NSLocalizedString("UnknownError", comment: "")
      case .timeout:
        return NSLocalizedString("ServerTimeoutTitle", comment: "")
      case .noAccess:
        return NSLocalizedString("401NoAccessTitle", comment: "")
      case .notFound:
        return NSLocalizedString("404NotFoundTitle", comment: "")
      }
    }
    
    func errorTitle() -> String {
      switch self {
      case .network:
        return NSLocalizedString("NetworkErrorTitle", comment: "")
      case .internetConnectionUnreachable:
        return NSLocalizedString("InternetConnectionErrorTitle", comment: "")
      case .unexpectedResponse, .unsuccessfulRequest, .requestCancelled:
        return NSLocalizedString("UnexpectedErrorTitle", comment: "")
      case .unauthorizedAccess:
        return NSLocalizedString("UnauthorizedAccessTitle", comment: "")
      case .serverError:
        return NSLocalizedString("ServerErrorTitle", comment: "")
      case .loginError:
        return NSLocalizedString("LoginErrorTitle", comment: "")
      case .other:
        return NSLocalizedString("UnknownErrorTitle", comment: "")
      case .timeout:
        return NSLocalizedString("ServerTimeoutError", comment: "")
      case .noAccess:
        return NSLocalizedString("401NoAccessError", comment: "")
      case .notFound:
        return NSLocalizedString("404NotFoundError", comment: "")
      }
    }
    
    func imageName() -> String {
      switch self {
      case .network, .internetConnectionUnreachable:
        return "ic_no_internet_connection"
      case .serverError:
        return "ic_server_error"
      case .unexpectedResponse, .unsuccessfulRequest, .requestCancelled, .unauthorizedAccess, .loginError, .other:
        return "ic_api_error"
      case .timeout:
        return "ic_server_timeout"
      case .noAccess:
        return "ic_no_access"
      case .notFound:
        return "ic_not_found"
      }
    }
  }
  
  private var internalErrorTitle: String?
  private var internalErrorMessage: String?
  private var internalImageName: String?
  var type: APIErrorType
  
  public var errorTitle: String {
    get {
      return internalErrorTitle != nil ? internalErrorTitle! : type.errorTitle()
    }
  }
  
  public var errorMessage: String {
    get {
      return internalErrorMessage != nil ? internalErrorMessage! : type.errorMessage()
    }
  }
  
  public var imageName: String {
    get {
      return internalImageName != nil ? internalImageName! : type.imageName()
    }
  }
  
  init(errorType: APIErrorType, errorTitle: String? = nil, errorMessage: String? = nil, errorImageName: String? = nil) {
    type = errorType
    internalErrorTitle = errorTitle
    internalErrorMessage = errorMessage
    internalImageName = errorImageName
  }
}

extension APIError {
  var isNetworkError: Bool {
    get {
      switch type {
      case .network, .internetConnectionUnreachable, .timeout:
        return true
      case .unexpectedResponse, .unsuccessfulRequest, .requestCancelled, .unauthorizedAccess, .serverError, .loginError, .other, .noAccess, .notFound:
        return false
      }
    }
  }
}
