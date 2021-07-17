//
//  NewsResponse.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - NewsResponse
//
public struct NewsResponse: Codable {
  let status: String?
  let totalResults: Int?
  let articles: [News]?
}

// MARK: - News
//
public struct News: Codable {
  let newsSource: SourceNews?
  let author: String?
  let title, articleDescription: String?
  let url: String?
  let urlToImage: String?
  var publishedAt: String?
  let content: String?
  

  enum CodingKeys: String, CodingKey {
    case author, title
    case articleDescription = "description"
    case newsSource = "source"
    case url, urlToImage, publishedAt, content
  }
}

// MARK: - Source
public struct SourceNews: Codable {
  let id: String?
  let name: String?
}
