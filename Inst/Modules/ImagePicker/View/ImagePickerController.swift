//
//  FourthViewController.swift
//  wq
//
//  Created by Роман on 23.11.2021.
//

import UIKit

class ImagePickerController: UIImagePickerController {
  
  var presenter: ImagePickerPresenterProtocol?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  private func setup() {
    
    self.cameraCaptureMode = .photo
    self.cameraFlashMode = .off
    self.cameraDevice = .front
    delegate = self
  }
  
}

extension ImagePickerController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    presenter?.catchPhotos(picker: picker, info: info)
  }
  
}

extension ImagePickerController: ImagePickerProtocol {
  
  
}




