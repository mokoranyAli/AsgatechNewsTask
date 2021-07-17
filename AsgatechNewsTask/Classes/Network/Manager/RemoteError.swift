//
//  RemoteError.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - RemoteError
//
/// This for handling connection error
///
enum RemoteError: Error, LocalizedError {
  case noInternet
  case notFound
  
  public var errorDescription: String? {
    switch self {
    case .noInternet:
      return "No network available, \n please check your WiFi or Data connection."
    case .notFound:
     return "Something went wrong, \n Please try again later."
    }
  }
}
