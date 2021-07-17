//
//  NewsCoordinator.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - NewsListCoordinator
//
final class NewsListCoordinator: NewsListCoordinatorProtocol {
  
  // MARK: - Properties
  
  unowned var navigationController: UINavigationController
  
  // MARK: - Init
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Handlers
  
  func start() {
    showNewsListViewController()
  }
  
  /// Show news list view controller
  ///
  private func showNewsListViewController() {
    let viewController = NewsListViewController()
    viewController.coordinator = self
    self.navigationController.setViewControllers([viewController], animated: false)
  }
}

// MARK: - Default implementation for news list navigation
//
protocol NewsListCoordinatorProtocol: class, Coordinator { }

extension NewsListCoordinatorProtocol {
  
  func showNewsDetails(with news: News) {
    let viewModel = NewsDetailsViewModel(news: news)
    let viewController = NewsDetailsViewController(viewModel: viewModel)
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
  }
}


