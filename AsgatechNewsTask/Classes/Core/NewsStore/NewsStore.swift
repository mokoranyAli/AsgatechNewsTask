//
//  NewsStore.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - NewsStore
//
/// This is for dealing with `NewsRemote` and handling data before or after fetching
///
class NewsStore: NewsStoreProtocol {
  
  // MARK: - Properties
  
  var remote: NewsRemoteProtocol?
  
  // MARK: - Init
  
  init(remote: NewsRemoteProtocol) {
    self.remote = remote
  }
  
  // MARK: - Handlers
  
  func fetchNews(request: NewsSearchRequest, onComplition: @escaping StoreNewsCompletionHandler) {
    remote?.getNews(request: request) { response, error in
      guard let response = response, error == nil, let news = response.articles else {
        onComplition(.failure(error ?? GeneralError()))
        return
      }
      onComplition(.success(news))
    }
  }
}

// MARK: - GeneralError
//
extension GeneralError: LocalizedError {
  
  public var errorDescription: String? {
    return "Something went wrong!"
  }
}

// MARK: - GeneralError
//
public struct GeneralError: Error {
  
  public init() { }
}
