import Foundation

/// SyncingCoordinator: Encapsulates all of the "Last Refreshed / Should Refresh" Paging Logic.
///
class SyncingCoordinator {
  
  /// Default Settings
  ///
  enum Defaults {
    
    static let pageSize = 20
    static let pageTTLInSeconds = TimeInterval(3 * 60)
  }
  
  /// Maps Page Numbers > Refresh Dates
  ///
  private var refreshDatePerPage = [Int: Date]()
  
  /// Indexes of the pages being currently Sync'ed
  ///
  private var pagesBeingSynced = IndexSet()
  
  /// First Page Index
  ///
  private(set) var page: Int
  
  /// Number of elements retrieved per request.
  ///
  let pageSize: Int
  
  /// Time (In Seconds) that must elapse before a Page is considered "expired".
  ///
  let pageTTLInSeconds: TimeInterval
  
  /// Designated Initializer
  ///
  init(page: Int = 1,
       pageSize: Int = Defaults.pageSize,
       pageTTLInSeconds: TimeInterval = Defaults.pageTTLInSeconds) {
    
    self.page = page
    self.pageSize = pageSize
    self.pageTTLInSeconds = pageTTLInSeconds
  }
  
  
  /// Should be called whenever a given Entity becomes visible. This method will:
  ///
  ///     1.  Proceed only if a given Element is the last one in it's page
  ///     2.  Verify if the (NEXT) page isn't being sync'ed (OR) if its cache has expired
  ///     3.  Proceed sync'ing the next page, if possible / needed
  ///
  func ensureNextPageIsSynchronized(lastVisibleIndex: Int) -> Bool {
    guard isLastElementInPage(elementIndex: lastVisibleIndex) else {
      return false
    }
    
    let nextPage = pageNumber(for: lastVisibleIndex) + 1
    guard !isPageBeingSynced(pageNumber: nextPage), isCacheInvalid(pageNumber: nextPage) else {
      return false
    }
    
    page = nextPage
    markAsBeingSynced(pageNumber: nextPage)
    markAsUpdated(pageNumber: nextPage)
    return true
  }
}

// MARK: - Analyzer Methods: For unit testing purposes, marking them as `Internal`
//
extension SyncingCoordinator {
  
  /// Resets all of the internal structures
  ///
  func resetInternalState() {
    page = 1
    pagesBeingSynced.removeAll()
    refreshDatePerPage.removeAll()
  }
  
  /// Maps an ObjectIndex to a PageNumber: [1, ...)
  ///
  func pageNumber(for objectIndex: Int) -> Int {
    return objectIndex / pageSize + 1
  }
  
  /// Indicates if the Cache for a given PageNumber is Invalid: Never Sync'ed (OR) TTL Expired
  ///
  func isCacheInvalid(pageNumber: Int) -> Bool {
    guard let elapsedTime = refreshDatePerPage[pageNumber]?.timeIntervalSinceNow else {
      return true
    }
    
    return abs(elapsedTime) > pageTTLInSeconds
  }
  
  /// Indicates if a given Element is the last one in the page. Note that `elementIndex` is expected to be in the [0, N) range.
  ///
  func isLastElementInPage(elementIndex: Int) -> Bool {
    return (elementIndex % pageSize) == (pageSize - 1)
  }
  
  /// Indicates if a given PageNumber is currently being synced
  ///
  func isPageBeingSynced(pageNumber: Int) -> Bool {
    return pagesBeingSynced.contains(pageNumber)
  }
}


// MARK: - Private Handlers
//
private extension SyncingCoordinator {
  
  /// Marks the specified PageNumber as just Updated
  ///
  func markAsUpdated(pageNumber: Int) {
    refreshDatePerPage[pageNumber] = Date()
  }
  
  /// Marks the specified PageNumber as "In Sync"
  ///
  func markAsBeingSynced(pageNumber: Int) {
    pagesBeingSynced.insert(pageNumber)
  }
}
