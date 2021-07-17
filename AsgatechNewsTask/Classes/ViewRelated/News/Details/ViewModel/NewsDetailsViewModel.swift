//
//  NewsDetailsViewModel.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - NewsDetailsViewModel
//
class NewsDetailsViewModel {
  
  // MARK: - Properties
  
  /// Selected news
  ///
  private let news: News
  
  /// Details to show
  ///
  var details: [(key: String?, value: String?)] = [] {
    didSet {
      shoudReloadData?()
    }
  }
  
  /// On should reload
  ///
  var shoudReloadData: (() -> Void)?
  
  // MARK: - Init
  
  init(news: News) {
    self.news = news
  }
  
  func viewDidLoad() {
    populateData()
  }
}

// MARK: - Public Handlers
//
extension NewsDetailsViewModel {
  
  /// To setup reload data callback
  ///
  func configureOnShouldReload(completion: @escaping () -> Void) {
    self.shoudReloadData = completion
  }
  
  /// Details items count
  ///
  var numberOfItems: Int {
    return details.count
  }
  
  /// Represented item with indexpath
  ///
  func item(at indexPath: IndexPath) -> (key: String?, value: String?) {
    return details[indexPath.row]
  }
  
  /// News Image
  ///
  var imageURL: String? {
    return news.urlToImage
  }
  
  /// News URL article to be opend in Safari
  ///
  var sourceURL: String? {
    return news.url
  }
}

// MARK: - Private Handlers
//
private extension NewsDetailsViewModel {
  func populateData() {
    details = [(Strings.title, news.title),
               (Strings.description, news.articleDescription),
               (Strings.author, news.author),
               (Strings.content, news.content),
               (Strings.source, news.newsSource?.name),
               (Strings.date, news.publishedAt),]
  }
}

// MARK: - Strings
//
private extension NewsDetailsViewModel {
  
  enum Strings {
    static let title = "Title"
    static let description = "Description"
    static let author = "Author"
    static let source = "Source"
    static let content = "Content"
    static let date = "Date"
  }
}
