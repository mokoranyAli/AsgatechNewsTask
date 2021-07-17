//
//  AppDelegate.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  /// App Window
  ///
  var window: UIWindow?
  
  /// AppDelegate's Instance
  ///
  static var shared: AppDelegate {
    guard let appInstance = UIApplication.shared.delegate as? AppDelegate else {
      fatalError()
    }
    return appInstance
  }
  
  /// Coordinates app navigation based on there is default .
  ///
  var coordinator: NewsListCoordinatorProtocol?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupMainWindow()
    return true
  }
  
  /// Sets up the main UIWindow instance wth app coordinator.
  ///
  func setupMainWindow() {
    let window = UIWindow()
    window.makeKeyAndVisible()
    self.window = window
    let navigationConroller = UINavigationController()
    self.window?.rootViewController = navigationConroller
    coordinator = NewsListCoordinator(navigationController: navigationConroller)
    coordinator?.start()
  }
}

