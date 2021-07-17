//
//  NewsTableViewCell.swift
//  AsgatechNewsTask
//
//  Created by Mohamed Korany on 7/16/21.
//

import UIKit

// MARK: - NewsTableViewCell
//
class NewsTableViewCell: UITableViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet private weak var sourceLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var newsImageView: UIImageView!
  
  // MARK: - Properties
  
  private var imageUrl: String!
  
  // MARK: - LifeCycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureView()
  }
}

// MARK: - View's Configuration
//
private extension NewsTableViewCell {
  
  func configureView() {
    sourceLabel.textColor = .lightGray
  }
}

// MARK: - Computed Properties
//
extension NewsTableViewCell {
  
  /// Image URL
  ///
  var imageURL: String? {
    get { return imageUrl }
    set { imageUrl = newValue; newsImageView.setImage(urlString: newValue) }
  }
  
  /// Description text
  ///
  var title: String? {
    get { descriptionLabel.text }
    set { descriptionLabel.text = newValue }
  }
  
  /// Source Text
  ///
  var source: String? {
    get { sourceLabel.text }
    set { sourceLabel.text = newValue }
  }
}
