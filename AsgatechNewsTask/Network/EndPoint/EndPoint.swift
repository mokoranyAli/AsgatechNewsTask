//
//  EndPoint.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Moya

// MARK: - EndPoint
//
enum EndPoint {
    case getNews(request: NewsSearchRequest)
}

// MARK: - EndPoint + TargetType
//
extension EndPoint: TargetType {
    
    var baseURL: URL {
        return Schema.baseURL
    }
    
    var path: String {
        switch self {
        
        case .getNews:
            return "everything"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        
        case .getNews(let request):
            return .requestParameters(parameters: [Strings.query: request.keyword,
                                                   Strings.key: Constants.API_Key_Value,
                                                   Strings.sortBy: Constants.API_sortByDate],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type":"application/json"]
    }
}


// MARK: - Constants
private extension EndPoint {
    
    enum Constants {
        static let API_Key_Value = "1943ddc16dc14f2e9e76374a493254c8"
        static let API_sortByDate = "publishedAt"
        
    }
    
    enum Strings {
        static let key = "apiKey"
        static let query = "q"
        static let sortBy = "sortBy"
    }
}
