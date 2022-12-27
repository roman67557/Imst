//
//  SixthViewPresenter.swift
//  ??
//
//  Created by Роман on 11.04.2022.
//

import Foundation
import UIKit

protocol UserViewProtocol {
  func moveToProfilePhoto(_ sender: Any)
}

protocol UserViewPresenterProtocol {
  init(view: UserViewProtocol, router: RouterProtocol)
  func moveToProfilePhoto(view: UIViewController)
  func openCamera(view: UIViewController)
  func openDetails(img: Types?, view: UIViewController, index: Int)
}

class UserViewPresenter: UserViewPresenterProtocol {
  
  var view: UserViewProtocol?
  var router: RouterProtocol?
  
  required init(view: UserViewProtocol, router: RouterProtocol) {
    self.view = view
    self.router = router
  }
  
  func moveToProfilePhoto(view: UIViewController) {
    
    //        view.navigationController?.pushViewController(profilePhotoVC, animated: true)
  }
  
  func openCamera(view: UIViewController) {
    router?.openCameraView(view: view)
  }
  
  func openDetails(img: Types?, view: UIViewController, index: Int) {
    router?.moveToDetailedController(img: img, view: view, index: index)
  }
  
}
