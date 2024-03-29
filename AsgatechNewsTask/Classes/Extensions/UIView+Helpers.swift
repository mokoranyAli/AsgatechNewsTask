//
//  UIView+Helpers.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - UIView Class Methods
//
extension UIView {
  
  /// Returns the Nib associated with the received: It's filename is expected to match the Class Name
  ///
  class func loadNib() -> UINib {
    return UINib(nibName: classNameWithoutNamespaces, bundle: nil)
  }
  
  /// Returns the first Object contained within the nib with a name whose name matches with the receiver's type.
  /// Note: On error this method is expected to break, by design!
  ///
  class func instantiateFromNib<T>() -> T {
    return loadNib().instantiate(withOwner: nil, options: nil).first as! T
  }
}
