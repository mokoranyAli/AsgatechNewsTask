//
//  NewsRequest.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

// MARK: - NewsSearchRequest
//
/// Wrapping news search request data
///
struct NewsSearchRequest {
  
  // MARK: - Properties
  
  let pageSize: Int 
  let page: Int
  let keyword: String?
}
