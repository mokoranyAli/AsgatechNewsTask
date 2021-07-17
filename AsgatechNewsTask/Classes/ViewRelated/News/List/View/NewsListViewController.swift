//
//  NewsListViewController.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - NewsListViewController
//
class NewsListViewController: ViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Properties
  
  /// Coordinator for news flow navigation
  ///
  weak var coordinator: NewsListCoordinatorProtocol?
  
  /// ViewModel for handling news flow logic like search, favorites..etc
  ///
  let viewModel = NewsListViewModel()
  
  /// Search controller for search all news
  ///
  private let searchController = UISearchController(searchResultsController: nil)
  
  /// Throttler to ensure that the function is called at most once in a specified time period
  ///
  private let throttler = Throttler(seconds: 1)
  
  /// Garbage Collector
  ///
  private let disposeBag = DisposeBag()
  
  /// Scroll watching instance to fire action on scrolling to end of screen
  ///
  private let scrollWatcher = ScrollWatcher()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
    configureViewModel()
    loadData()
  }
  
  // MARK: - Override Methods
  
  @discardableResult
  override func bindErrorState(to viewModel: ViewModel) -> ObservationToken {
    viewModel.state.subscribe { [weak self] state in
      if case .failure(let error) = state {
        self?.reloadSectionsAndData()
        self?.showPlaceholderViewWithError(error)
      }
    }
  }
  
  // Remove this if wanna interact with UI during fetching
  //
  override var progressType: ProgressViewType {
    return .fullscreen
  }
}

// MARK: - Configure View
//
private extension NewsListViewController {
  
  func configureView() {
    configureSearchController()
    configureTableView()
    configureTitle()
    configureScrollWatcher()
    configurePaginationTracker()
  }
  
  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = Strings.searchPlaceHolder
    searchController.searchBar.barStyle = .default
    let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField
    textfield?.layer.cornerRadius = 15
    textfield?.layer.borderWidth = 1
    textfield?.layer.borderColor = UIColor.lightGray.cgColor
    navigationItem.searchController = searchController
    searchController.becomeFirstResponder()
    definesPresentationContext = true
  }
  
  func configureTitle() {
    self.title = Strings.title
  }
  
  func configureScrollWatcher() {
    scrollWatcher.startObservingScrollPosition(tableView: tableView)
  }
}

// MARK: - Configure Table View
//
private extension NewsListViewController {
  
  func configureTableView() {
    tableView.dataSource = viewModel.dataSource
    tableView.delegate = self
    tableView.tableFooterView = UIView()
    registerCells(in: tableView)
    configureRefreshControl(in: tableView)
  }
  
  func registerCells(in tableView: UITableView) {
    tableView.registerCellNib(NewsTableViewCell.self)
  }
  
  
  func configureRefreshControl(in tableView: UITableView) {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
}

// MARK: - Configure ViewModel
//
private extension NewsListViewController {
  
  func configureViewModel() {
    bindErrorState(to: viewModel)
    bindLoadingState(to: viewModel)
    configureOnLoadData()
    configureOnShowDetails()
  }
  
  func configureOnLoadData() {
    viewModel.dataObservable.subscribe { [weak self] _ in
      self?.reloadSectionsAndData()
      self?.showEmptyResultsViewIfNeeded()
    }.disposed(by: disposeBag)
  }
  
  func configureOnShowDetails() {
    viewModel.configureOnShowToDetails { [weak self] in
      self?.coordinator?.showNewsDetails(with: $0)
    }
  }
}

// MARK: - Actions
//
private extension NewsListViewController {
  
  @objc func refreshControlValueChanged(_ sender: UIRefreshControl) {
    loadData()
  }
}

// MARK: - Handlers
//
private extension NewsListViewController {
  
  func loadData() {
    viewModel.load()
  }
  
  /// Reload data source data then reload table view
  ///
  func reloadSectionsAndData() {
    viewModel.dataSource.reloadSections()
    tableView.reloadData()
  }
  
  /// Show empty results view if needed
  ///
  func showEmptyResultsViewIfNeeded() {
    let isEmpty = viewModel.dataSource.isEmpty
    let message = Strings.emptyResultsMessage
    showNoResultsView(isEmpty, title: Strings.warning, message: message, image: .warning)
  }
  
  /// Shows error if extsis. Will hide the view if the error is nil
  ///
  func showPlaceholderViewWithError(_ error: Error) {
    
    let error = error as? LocalizedError
    let message = error?.errorDescription ?? error?.localizedDescription
    let shouldShow = error != nil
    showNoResultsView(shouldShow, title: Strings.error, message: message, image: .error)
  }
  
  /// Handle the presentation of `No results view`
  ///
  private func showNoResultsView(_ shouldShow: Bool,
                                 title: String,
                                 message: String?,
                                 image: UIImage) {
    shouldShow ? tableView.setEmptyView(title: title, message: message!, messageImage: image) : tableView.restore()
  }
  
  func configurePaginationTracker() {
    scrollWatcher.trigger.subscribe { [weak self] _ in
      guard let self = self else { return }
      let lastVisibleIndex = self.viewModel.dataSource.lastVisibleIndex.row
      self.viewModel.hitPagination(lastVisibleIndex: lastVisibleIndex)
    }.disposed(by: disposeBag)
  }
}

// MARK: - UITableViewDelegate Conformance
//
extension NewsListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelectItem(at: indexPath)
  }
}


// MARK: - UISearchResultsUpdating Delegate
//
extension NewsListViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text, !text.isEmpty else { return }
    
    throttler.throttle { [weak self] in
      self?.viewModel.searchDidChanged(with: text)
    }
  }
}

// MARK: - Constants
//
private extension NewsListViewController {
  
  enum Strings {
    static let searchPlaceHolder = "Search All News..."
    static let error = "Error"
    static let emptyResultsMessage = "No data found"
    static let warning = "Warning"
    static let title = "News"
  }
}
