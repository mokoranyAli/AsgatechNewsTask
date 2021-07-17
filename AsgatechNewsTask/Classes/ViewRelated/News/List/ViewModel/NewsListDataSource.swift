//
//  NewsListDataSource.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation
import UIKit

// MARK: - NewsListDataProvider

/// To get one list only in view model and  data source
///
protocol NewsListDataProvider: class {
  var list: [News] { get }
}

// MARK: - NewsListDataSource
//
class NewsListDataSource: NSObject {
  
  // MARK: - Proeprties
  
  /// Sections list
  ///
  var sections: [Section] = []
  
  /// Data Provider for getting news list
  weak var dataProvider: NewsListDataProvider?
  
  /// Last visible index in tableview .. used for pagination
  ///
  private(set) var lastVisibleIndex: IndexPath = IndexPath()
  
  // MARK: - Init
  
  init(dataProvider: NewsListDataProvider) {
    self.dataProvider = dataProvider
  }
}

// MARK: - Computed Properties
//
extension NewsListDataSource {
  
  var list: [News] {
    return dataProvider?.list ?? []
  }
}

// MARK: - Helpers
//
extension NewsListDataSource {
  
  func item(at indexPath: IndexPath) -> News? {
    return sections[indexPath.section].rows[indexPath.row].item
  }
  
  var isEmpty: Bool {
    return sections.isEmpty
  }
}

// MARK: - Handle handlers for tableview
//
extension NewsListDataSource: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].rows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(NewsTableViewCell.self)
    configureNewsCell(cell, at: indexPath)
    lastVisibleIndex = indexPath
    return cell
  }
}

// MARK: - UITableViewDataSource conformance helpers
//
extension NewsListDataSource {
  
  func configureNewsCell(_ cell: NewsTableViewCell, at indexPath: IndexPath) {
    let item = sections[indexPath.section].rows[indexPath.row].item
    cell.title = item.articleDescription
    cell.source = item.newsSource?.name
    cell.imageURL = item.urlToImage
  }
}

// MARK: - Support for UITableViewDelegate
//
extension NewsListDataSource {

  func heightForRowAt(_ indexPath: IndexPath, tableView: UITableView) -> CGFloat {
    return UITableView.automaticDimension
  }
}

// MARK: - Reload Sections
//
extension NewsListDataSource {
  
  /// Reload sections
  ///
  func reloadSections() {
    self.sections = {
      let newsRows = list.map { Row(item: $0)}
      let newsSection = Section(rows: newsRows)
      return newsRows.isEmpty ? [] : [newsSection]
    }()
  }
}

// MARK: - Constants
//
extension NewsListDataSource {
  
  struct Section {
    var rows: [Row]
  }
  
  struct Row {
    let reuseIdenefier: String = NewsTableViewCell.reuseIdentifier
    let item: News
  }
}
