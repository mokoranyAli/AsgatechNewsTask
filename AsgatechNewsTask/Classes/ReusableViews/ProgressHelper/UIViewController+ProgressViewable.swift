//
//  ProgressType.swift
//  MyNews
//
//  Created by Mohamed Korany on 5/19/21.
//  Copyright © 2020 VictoryLink. All rights reserved.
//

import UIKit

// MARK: - ProgressViewable
//
@objc extension UIViewController: ProgressViewable {
  
  var progressType: ProgressViewType {
    return .view
  }
  
  func shouldShowProgressView(_ show: Bool, type: ProgressViewType) {
    DispatchQueue.main.async {
      switch type {
      case .view:
        show ? self.showInView() : self.hideForView()
      case .fullscreen:
        show ? self.showInWindow() : self.hideForWindow()
      }
    }
  }
}

// MARK: - Private Handlers
//
private extension UIViewController {
  
  func showInView() {
    view.endEditing(true)
    InProgressView.showAdded(to: self.view, properties: .viewProperties)
  }
  
  func hideForView() {
    InProgressView.hide(for: view)
  }
  
  func showInWindow() {
    if let window = AppDelegate.shared.window {
      view.endEditing(true)
      InProgressView.showAdded(to: window, properties: .fullscreenProperties)
    }
  }
  
  func hideForWindow() {
    if let window = AppDelegate.shared.window {
      InProgressView.hide(for: window)
    }
  }
}

// MARK: - View & Fullscreen Proeprties
//
private extension InProgressViewProperties {
  
  static let viewProperties = InProgressViewProperties(style: nil)
  
  static let fullscreenProperties = InProgressViewProperties(style: .dark)
  
}
