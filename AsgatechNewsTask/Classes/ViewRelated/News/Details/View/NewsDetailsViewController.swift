//
//  NewsDetailsViewController.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - NewsDetailsViewController
//
class NewsDetailsViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  
  /// Coordinator for news flow navigation
  ///
  weak var coordinator: NewsListCoordinatorProtocol?
  
  /// News Details View Model
  ///
  let viewModel: NewsDetailsViewModel
  
  /// Footer Button
  ///
  lazy var buttonAction: ButtonAction = {
    return ButtonAction(title: Strings.showFull) { [weak self] _ in
      self?.showSource()
    }
  }()
  
  // MARK: - Init
  
  init(viewModel: NewsDetailsViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    viewModel.viewDidLoad()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.updateFooterHeight()
  }
}

// MARK: - View's Configuration
//
private extension NewsDetailsViewController {
  
  func configureView() {
    configureTableView()
  }
  
  func configureTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = buttonAction.button
    registerCells(in: tableView)
    configureHeaderView()
  }
  
  func registerCells(in tableView: UITableView) {
    tableView.registerCellNib(KeyValueTableViewCell.self)
  }
  
  func configureHeaderView() {
    let headerView = StretchyTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250))
    headerView.imageView.setImage(urlString: viewModel.imageURL)
    tableView.tableHeaderView = headerView
  }
}

// MARK: - Private Handlers
//
private extension NewsDetailsViewController {
  
  func showSource() {
    let url = viewModel.sourceURL
    WebviewHelper.launch(url, with: self)
  }
}

// MARK: - ScrollView Delegate
//
/// For `StretchyTableHeaderView`
///
extension NewsDetailsViewController: UIScrollViewDelegate, UITableViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let headerView = tableView.tableHeaderView as? StretchyTableHeaderView
    headerView?.scrollViewDidScroll(scrollView: scrollView)
  }
}

// MARK: - DataSource Confrmance
//
extension NewsDetailsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.numberOfItems
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(KeyValueTableViewCell.self)
    let item = viewModel.item(at: indexPath)
    configureCellWithItem(cell, item)
    return cell
  }
  
  func configureCellWithItem(_ cell: KeyValueTableViewCell, _ item: (key: String?, value: String?)) {
    cell.key = item.key
    cell.value = item.value
  }
}

// MARK: - Strings
//
private extension NewsDetailsViewController {
  
  enum Strings {
    static let showFull = "Show Full Details"
  }
}
