//
//  NewsRemote.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - NewsRemote
//
/// For Fetching data from `News` APIs
///
class NewsRemote {
    
    // MARK: - Properties
    
    var network: Networkable
    
    // MARK: - Init
    
    init(network: Networkable) {
        self.network = network
    }
}

// MARK: - NewsRemote + NewsRemoteProtocol (Fetching...)
//
extension NewsRemote: NewsRemoteProtocol {
    
    func getNews(request: NewsSearchRequest, completionHandler: @escaping RemoteNewsCompletionHandler) {
        let target: EndPoint = .getNews(request: request)
        network.makeRequest(target: target, complitionHandler: completionHandler)
    }
}
