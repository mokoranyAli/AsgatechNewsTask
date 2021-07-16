//
//  Schema.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - Schema
//
public enum Schema: String {
  
  /// Debug
  ///
  case debug = "Debug"
  
  /// Release
  ///
  case release = "Release"
  
  /// Return the current schema fetched from user info with key `CURRENT_SCHEME_NAME`.
  ///
  /// For unit testing, We return `debug` by default.
  ///
  static public let current: Schema = {
    if isRunningTests() {
      return .debug
    }
    
    guard let rawValue: String = obejct(for: .buildEnvironment),
          let value = Schema(rawValue: rawValue) else {
      fatalError("Unable to get current schema!")
    }
    
    return value
  }()
  
  /// Returns object for `info` key.
  ///
  static func obejct<T>(for key: Key) -> T {
    guard let value = Bundle.main.infoDictionary?[key.rawValue] as? T else {
      fatalError("Unable to get value for info.plist key \(key)")
    }
    
    return value
  }
}

// MARK: - Keys: User Defined Keys
//
extension Schema {
  
  enum Key: String {
    case baseUrl = "BASE_URL"
    case buildEnvironment = "BUILD_ENVIRONMENT"
  }
}

// MARK: - Helpres
//
private extension Schema {
    static func isRunningTests() -> Bool {
        return NSClassFromString("XCTestCase") != nil
    }
}

// MARK: - Helper Properties: User Defined Keys Properties
//
extension Schema {
  
  /// Base url for remote accessing
  /// It dependes on current scheme like debug, release or testing
  ///
  static var baseURL: URL {
    guard let url = URL(string: Schema.obejct(for: .baseUrl)) else {
      fatalError("Unable to create base url")
    }
    
    return url
  }
}
