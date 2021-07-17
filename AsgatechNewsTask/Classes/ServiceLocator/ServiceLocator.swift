//
//  ServiceLocator.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

/// Provides global dependencies.
///
final class ServiceLocator {
  
  // MARK: - Private properties
  
  /// News Store
  ///
  private static var _store: NewsStoreProtocol = NewsStore(remote: NewsRemote(network: NetworkManager()))
    
  // MARK: - Getters
  
  /// Provides the access point to the news store.
  static var newsStore: NewsStoreProtocol {
    return _store
  }
}

// MARK: - For Testing

/// In case of wanna add unit test
/// The setters declared in this extension are meant to be used only from the test bundle
extension ServiceLocator {
  static func setNewsStore(_ mock: NewsStoreProtocol) {
    guard isRunningTests() else {
      return
    }
    _store = mock
  }
}

// MARK: - Testing checker
//
private extension ServiceLocator {
  static func isRunningTests() -> Bool {
    return NSClassFromString("XCTestCase") != nil
  }
}

