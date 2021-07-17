//
//  NewsRemoteProtocol.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - Typealias
typealias RemoteNewsCompletionHandler = (NewsResponse?, Error?) -> Void

// MARK: - NewsRepoProtocol
//
protocol NewsRemoteProtocol {
  
  // MARK: - Properties
  var network: Networkable {get set}
  
  /// every news
  ///
  func getNews(request: NewsSearchRequest, completionHandler: @escaping RemoteNewsCompletionHandler)
}
