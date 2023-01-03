//
//  UpdatesTableViewCell.swift
//  wq
//
//  Created by Роман on 24.12.2021.
//

import UIKit

class UpdatesTableViewCell: UITableViewCell {
  
  static let identifier = "UpdatesTableViewCell"
  private let photoImageView = UIImageView()
  
  public func setup(data: ShooterdImages) {
    
    guard let date = data.date, let imgData = data.img else { return }
    
    self.textLabel?.text = "\(date): user added a photo"
    let img = UIImage(data: imgData)
    
    photoImageView.contentMode = .scaleAspectFit
    photoImageView.image = img
    
    self.accessoryView = photoImageView
    self.accessoryView?.frame = CGRectMake(0, 0, 40, 40)
    self.selectionStyle = .none
  }
  
}
