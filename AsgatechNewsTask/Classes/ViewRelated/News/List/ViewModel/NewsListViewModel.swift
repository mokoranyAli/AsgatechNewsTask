//
//  NewsListViewModel.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

// MARK: - NewsListViewModel
//
class NewsListViewModel: ViewModel {
  
  // MARK: - Properties
  
  /// News store for dealing with remote
  ///
  private let store: NewsStoreProtocol
  
  /// Indicates the search key word
  ///
  private var query: String?
  
  /// When data loaded each time
  ///
  private let dataLoadingSubject = PublishSubject<Void>()
  
  /// Articles
  ///
  private var value: [News] = []
  
  /// News data source for handling data representation
  ///
  lazy var dataSource: NewsListDataSource = {
    return NewsListDataSource(dataProvider: self)
  }()
  
  /// When navigate to details
  ///
  private var shouldNavigateToDetails: ((News) -> Void)?
  
  /// Used for pagination
  /// SyncCoordinator: Keeps tracks of which pages have been refreshed, and encapsulates the "What should we sync now" logic.
  ///
  private let syncingCoordinator = SyncingCoordinator()
  
  // MARK: - Init
  
  init(store: NewsStoreProtocol = ServiceLocator.newsStore) {
    self.store = store
  }
}

// MARK: - Data Providing
//
/// For give value to datasource, we don't need to have multiple lists
///
extension NewsListViewModel: NewsListDataProvider {
  var list: [News] {
    return value
  }
}

// MARK: - Public Handlers
//
extension NewsListViewModel {
  
  func load() {
    loadNews()
  }
  
  func hitPagination(lastVisibleIndex: Int) {
    paginateIfPossible(with: lastVisibleIndex)
  }
  
  func configureOnShowToDetails(completion: @escaping (News) -> Void) {
    self.shouldNavigateToDetails = completion
  }
  
  func didSelectItem(at indexPath: IndexPath) {
    if let item = dataSource.item(at: indexPath) {
      shouldNavigateToDetails?(item)
    }
  }
  
  func searchDidChanged(with text: String) {
    updateTextAndFetch(text)
  }
}

// MARK: - Private Handlers
//
private extension NewsListViewModel {
  
  func updateTextAndFetch(_ text: String) {
    query = text
    syncingCoordinator.resetInternalState()
    load()
  }
  
  
  func paginateIfPossible(with lastVisibleIndex: Int) {
    if syncingCoordinator.ensureNextPageIsSynchronized(lastVisibleIndex: lastVisibleIndex) {
      loadNews(with: .pagination)
    }
  }
}

// MARK: - Computed Properties
//
extension NewsListViewModel {
  
  var dataObservable: Observable<Void> {
    return dataLoadingSubject
  }
}

// MARK: - Networking
//
private extension NewsListViewModel {
  
  func loadNews(with type: FetchingType = .search) {
    state.send(.loading)
    let request = NewsSearchRequest(pageSize: syncingCoordinator.pageSize, page: syncingCoordinator.page, keyword: query)
    store.fetchNews(request: request) { [weak self] result in
      
      switch result {
      case .success(let list):
        self?.didReciveNews(list: list, type: type)
        self?.dataLoadingSubject.send(())
        self?.state.send(.success)
      case .failure(let error):
        self?.value = [] // this is because handle error with empty view if we are make pagination
        self?.state.send(.failure(error))
      }
    }
  }
  
  func didReciveNews(list: [News], type: FetchingType) {
    
    switch type {
    case .search:
      value = list
    case .pagination:
      value += list
    }
  }
}

// MARK: - Fetching mode
//
private extension NewsListViewModel {
  
  /// Indicates fetching approach either `Search` or `Pagination`
  /// This helps because when fetch with search is different from fetch with pagination
  ///
  enum FetchingType {
    case search
    case pagination
  }
}
