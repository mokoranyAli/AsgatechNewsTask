//
//  UITableView+Helpers.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - UITableView + Hanldlers
//
extension UITableView {
  
  /// Called in view controller's `viewDidLayoutSubviews`. If table view has a footer view, calculates the new height.
  /// If new height is different from current height, updates the footer view with the new height and reassigns the table footer view.
  /// Note: make sure the top-level footer view (`tableView.tableFooterView`) is frame based as a container of the Auto Layout based subview.
  func updateFooterHeight() {
    if let footerView = tableFooterView {
      let targetSize = CGSize(width: footerView.frame.width, height: 0)
      let newSize = footerView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
      let newHeight = newSize.height
      var currentFrame = footerView.frame
      if newHeight != currentFrame.size.height {
        currentFrame.size.height = newHeight
        footerView.frame = currentFrame
        tableFooterView = footerView
      }
    }
  }
  
  func registerCellNib<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
    let nibName = reuseIdentifier ?? T.classNameWithoutNamespaces
    self.register(T.loadNib(), forCellReuseIdentifier: nibName)
  }
  
  func registerCellClass<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
    let nibName = reuseIdentifier ?? T.classNameWithoutNamespaces
    self.register(T.self, forCellReuseIdentifier: nibName)
  }
  
  /// Dequeue cell with generics
  func dequeue<T: UITableViewCell>(_: T.Type) -> T {
    guard
      let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T
    else { fatalError("Could not deque cell with type \(T.self)") }
    
    return cell
  }
}

// MARK: - Handling Empty View
//
extension UITableView {
  
  func setEmptyView(title: String, message: String, messageImage: UIImage) {
    
    let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
    
    let messageImageView = UIImageView()
    let titleLabel = UILabel()
    let messageLabel = UILabel()
    
    messageImageView.backgroundColor = .clear
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    messageImageView.translatesAutoresizingMaskIntoConstraints = false
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    
    titleLabel.textColor = .black
    
    titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    
    messageLabel.textColor = UIColor.lightGray
    messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
    emptyView.addSubview(titleLabel)
    emptyView.addSubview(messageImageView)
    emptyView.addSubview(messageLabel)
    
    messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
    messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
    messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
    messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    
    titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
    titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
    
    messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
    messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
    
    messageImageView.image = messageImage
    titleLabel.text = title
    messageLabel.text = message
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    
    UIView.animate(withDuration: 1, animations: {
      
      messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
    }, completion: { (finish) in
      UIView.animate(withDuration: 1, animations: {
        messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
      }, completion: { (finishh) in
        UIView.animate(withDuration: 1, animations: {
          messageImageView.transform = CGAffineTransform.identity
        })
      })
      
    })
    
    self.backgroundView = emptyView
    self.separatorStyle = .none
  }
  
  func restore() {
    self.backgroundView = nil
  }
}
