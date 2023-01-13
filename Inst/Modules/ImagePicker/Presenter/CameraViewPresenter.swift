//
//  CameraViewPresenter.swift
//  ??
//
//  Created by Роман on 13.03.2022.
//

import Foundation
import UIKit

protocol CameraViewProtocol: AnyObject {
  
}

protocol CameraViewPresenterProtocol {
  init(view: CameraViewProtocol, router: RouterProtocol)
  func catchPhotos(img: Data?)
}

final class CameraViewPresenter: CameraViewPresenterProtocol {
  
  //MARK: - Private Properties
  
  private weak var view: CameraViewProtocol?
  private let router: RouterProtocol?
  
  //MARK: - Initializers
  
  required init(view: CameraViewProtocol, router: RouterProtocol) {
    self.view = view
    self.router = router
  }
  
  //MARK: - Public Methods
  
  public func catchPhotos(img: Data?) {
    let date = Date()
    let df = DateFormatter()
    df.dateFormat = "MMM d, h:mm a"
    let dateString = df.string(from: date)
    
    DatabaseHandler.shared.saveImage(imgData: img, date: dateString)
  }
  
}
