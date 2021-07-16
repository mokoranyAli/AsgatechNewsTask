//
//  NetworkManager.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation
import Moya

// MARK: - Networkable
//
protocol Networkable {
  func makeRequest<T: Codable>(target: EndPoint , complitionHandler: @escaping (T?, RemoteError?) -> Void)
  
}

// MARK: - NewtorkManger
//
class NetworkManager: Networkable {
  
  fileprivate let provider = MoyaProvider<EndPoint>(plugins: [NetworkManager.loggingPlugin()])
  
  func makeRequest<T: Codable>(target: EndPoint , complitionHandler: @escaping (T?, RemoteError?) -> Void) {
    
    provider.request(target) { (result) in
      switch  result {
      case .success(let response) :
        do {
          let resultApi = try JSONDecoder().decode(T.self, from: response.data)
          complitionHandler(resultApi, nil)
        }
        catch(let ex) {
          print(#function, "exception with: \(ex)")
          complitionHandler(nil, .notFound)
        }
        
      case .failure(let error) :
        print(#function, "error with: \(error)")
        complitionHandler(nil, .noInternet)
      }
    }
  }
}

// MARK: Helpers
//
private extension NetworkManager {
  
  /// Logging plugin
  ///
  static func loggingPlugin() -> NetworkLoggerPlugin {
    NetworkLoggerPlugin(
      configuration: .init(logOptions: .verbose)
    )
  }
}


