//
//  UIImage+Constants.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - UIImage + App
//
extension UIImage {
  
  // MARK: - Images
  
  static var placeHolder: UIImage {
    return UIImage(named: "placeholder-image-icon") ?? .add
  }
  
  static var warning: UIImage {
    return UIImage(named: "warning") ?? .add
  }
  
  static var error: UIImage {
    return UIImage(named: "error") ?? .add
  }
}

