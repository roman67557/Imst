//
//  Alert.swift
//  Inst
//
//  Created by Роман on 13.01.2023.
//

import UIKit

class AlertController: UIAlertController {
  
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
  
  private func setup() {
    
    let action = UIAlertAction(title: "Ok", style: .default) { [weak self] action in
      self?.dismiss(animated: true)
    }
    
    self.addAction(action)
  }

}
