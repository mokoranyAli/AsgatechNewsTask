//
//  AlertDisplayer.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//
import UIKit

// MARK: - AlertDisplayer
//
protocol AlertDisplayer {
  func displayAlert(with title: String?, message: String?, actions: [UIAlertAction]?)
  func displayErrorAlert(with title: String?, message: String?)
}

// MARK: - UIViewController+AlertDisplayer
//
extension AlertDisplayer where Self: UIViewController {
  func displayAlert(with title: String?, message: String?, actions: [UIAlertAction]? = nil) {
    guard presentedViewController == nil else {
      return
    }
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    actions?.forEach { action in
      alertController.addAction(action)
    }
    present(alertController, animated: true)
  }
  
  func displayErrorAlert(with title: String?, message: String?) {
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    displayAlert(with: title, message: message, actions: [action])
  }
  
  func showErrorAlert(error: Error, handler: UIAlertAction? = nil) {
    let okAction = UIAlertAction(title: "OK", style: .default)
    let message = (error as? LocalizedError)?.errorDescription ?? error.localizedDescription
    displayAlert(with: nil, message: message, actions: [okAction])
  }
}

// MARK: - UIViewController+AlertDisplayer
//
extension UIViewController: AlertDisplayer { }

