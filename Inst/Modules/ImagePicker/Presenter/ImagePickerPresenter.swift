//
//  HeroViewPresenter.swift
//  ??
//
//  Created by Роман on 13.03.2022.
//

import Foundation
import UIKit

protocol ImagePickerProtocol {
  
}

protocol ImagePickerPresenterProtocol {
  init(view: ImagePickerProtocol, router: RouterProtocol)
  func catchPhotos(picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any])
}

class ImagePickerPresenter: ImagePickerPresenterProtocol {
  
  let view: ImagePickerProtocol?
  let router: RouterProtocol?
  
  required init(view: ImagePickerProtocol, router: RouterProtocol) {
    self.view = view
    self.router = router
  }
  
  func catchPhotos(picker: UIImagePickerController, info: [UIImagePickerController.InfoKey : Any]) {
    if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      
      let date = Date()
      let df = DateFormatter()
      df.dateFormat = "MMM d, h:mm a"
      let dateString = df.string(from: date)
      
      print(date)
      
      let image = pickedImage.correctlyOrientedImage()
      
      DatabaseHandler.shared.saveImage(img: image, date: dateString)
    } else { return }
    picker.dismiss(animated: true)
  }
  
}
