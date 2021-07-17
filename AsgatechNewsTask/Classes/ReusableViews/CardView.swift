//
//  CardView.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - Customized CardView
//
class CardView: UIView {
  
  /// Card view back ground color (default to white)
  ///
  var bgColor: UIColor? = .white

  // MARK: - Init
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    makeCardView()
  }
  
  // MARK: - Helper
  
  private func makeCardView() {
    self.backgroundColor = bgColor
    self.clipsToBounds = true
    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOpacity = Constants.shadowOpacity
    self.layer.shadowOffset = CGSize.zero
    self.layer.shadowRadius = Constants.shadowRadius
    self.layer.cornerRadius = Constants.cornerRadius
  }
}

// MARK: - Constant
//
private extension CardView {
  
  enum Constants {
    static let shadowOpacity = Float(0.2)
    static let cornerRadius = CGFloat(8)
    static let shadowRadius = CGFloat(4)
  }
}
