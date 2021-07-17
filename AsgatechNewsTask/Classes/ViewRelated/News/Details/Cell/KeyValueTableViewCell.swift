//
//  KeyValueTableViewCell.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - KeyValueTableViewCell
//
/// This is used Here for representing news details
///
class KeyValueTableViewCell: UITableViewCell {

  // MARK: - IBOutlets
  
  @IBOutlet private weak var keyLabel: UILabel!
  @IBOutlet private weak var valueLabel: UILabel!
  
  // MARK: - LifeCycle
  
  override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
}

// MARK: - View's Configuration
//
private extension KeyValueTableViewCell {
  
  func configureView() {
    configureKeyLabel()
    configureValueLabel()
  }
  
  func configureKeyLabel() {
    keyLabel.font = .preferredFont(forTextStyle: .title1)
  }
  
  func configureValueLabel() {
    valueLabel.font = .preferredFont(forTextStyle: .caption1)
    valueLabel.textColor = .lightGray
  }
}

// MARK: - Computed Properties
//
extension KeyValueTableViewCell {
  
  /// Key text
  ///
  var key: String? {
    get { keyLabel.text }
    set { keyLabel.text = newValue }
  }
  
  /// Value text
  ///
  var value: String? {
    get { valueLabel.text }
    set { valueLabel.text = newValue }
  }
}
