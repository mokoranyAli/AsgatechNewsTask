//
//  UITableViewCell+ReuseIdentifier.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - UITableViewCell + Helpers
//
extension UITableViewCell {
  
  /// Returns a reuseIdentifier that matches the receiver's classname (non namespaced).
  ///
  class var reuseIdentifier: String {
    return classNameWithoutNamespaces
  }
}
