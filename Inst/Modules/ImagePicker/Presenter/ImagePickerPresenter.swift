//
//  HeroViewPresenter.swift
//  ??
//
//  Created by Роман on 13.03.2022.
//

import Foundation
import UIKit

protocol CameraViewProtocol {
  
}

protocol CameraViewPresenterProtocol {
  init(view: CameraViewProtocol, router: RouterProtocol)
  func catchPhotos(img: Data?)
}

class CameraViewPresenter: CameraViewPresenterProtocol {
  
  let view: CameraViewProtocol?
  let router: RouterProtocol?
  
  required init(view: CameraViewProtocol, router: RouterProtocol) {
    self.view = view
    self.router = router
  }
  
  func catchPhotos(img: Data?) {
    let date = Date()
    let df = DateFormatter()
    df.dateFormat = "MMM d, h:mm a"
    let dateString = df.string(from: date)
    
    DatabaseHandler.shared.saveImage(imgData: img, date: dateString)
  }
  
}
