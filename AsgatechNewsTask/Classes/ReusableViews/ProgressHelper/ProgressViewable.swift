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
protocol ProgressViewable {
  
  /// Default `ProgressType` for loading view.
  var progressType: ProgressViewType { get }
  
  /// Show loading view
  ///
  /// - parameter show: Shows progress view.
  /// - parameter type: set progress view type.
  func shouldShowProgressView(_ show: Bool, type: ProgressViewType)
  
}
