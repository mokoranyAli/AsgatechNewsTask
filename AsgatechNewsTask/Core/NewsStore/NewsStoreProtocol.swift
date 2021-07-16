//
//  NewsStoreProtocol.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - Typealiases

typealias StoreNewsCompletionHandler = (Result<[News], Error>) -> Void

// MARK: - NewsStoreProtocol
//
protocol NewsStoreProtocol {
    
    // MARK: - Properties
    
    var remote: NewsRemoteProtocol? {get set}
    
    // MARK: - Handlers
    
    /// Fetch news
    ///
    func fetchNews(request: NewsSearchRequest, onComplition: @escaping StoreNewsCompletionHandler)
}
