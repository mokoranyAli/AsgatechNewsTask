//
//  NSObject+Helpers.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation

/// NSObject: Helper Methods
///
extension NSObject {
  
  /// Returns the receiver's classname as a string, not including the namespace.
  ///
  class var classNameWithoutNamespaces: String {
    return String(describing: self)
  }
}
