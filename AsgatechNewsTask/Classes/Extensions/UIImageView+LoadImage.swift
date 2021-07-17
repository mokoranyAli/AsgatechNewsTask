//
//  UIImageView+LoadImage.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit
import Kingfisher

// MARK: - ImageLoader
//
protocol ImageLoader {
  
  /// Set image using url as string and placeholder image in case of failure to fetch the image
  ///
  func setImage(urlString: String?, placeholder: UIImage?)
}

// MARK: - UIImageView + ImageLoader Conformance
//
extension UIImageView: ImageLoader {
  
  func setImage(urlString: String?, placeholder: UIImage? = .placeHolder) {
    let url = URL(string: urlString ?? "")
    self.kf.setImage(with: url, placeholder: placeholder)
  }
}
