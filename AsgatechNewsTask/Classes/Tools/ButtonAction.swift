//
//  ButtonAction.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import Foundation
import UIKit

// MARK: - ButtonAction
//
class ButtonAction: NSObject {
  
  /// Button Handler
  ///
  typealias Handler = ((ButtonAction) -> Void)
  
  // MARK: Properties
  
  /// Button Title
  ///
  let title: String?
  
  /// Button Click  handler
  ///
  let handler: Handler?
  
  // MARK: Init
  
  init(title: String?, handler: Handler? = nil) {
    self.title = title
    self.handler = handler
    super.init()
  }
  
  // MARK: - Computed Properties
  
  /// Alert button
  ///
  lazy var button: UIButton = {
    let button = makeButton()
    configureOnTapButton(button)
    return button
  }()
  
  // MARK: - Handlers
  
  /// Called when user taps the button
  ///
  @objc private func didTapButton(_ sender: UIButton) {
    handler?(self)
  }
}

// MARK: - Button Maker
//
private extension ButtonAction {
  
  /// Returns a button for the current action style.
  ///
  func makeButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    return button
  }
  
  /// Configure button on tap action
  ///
  func configureOnTapButton(_ button: UIButton) {
    button.addTarget(self,
                     action: #selector(didTapButton(_:)),
                     for: .touchUpInside)
  }
}

