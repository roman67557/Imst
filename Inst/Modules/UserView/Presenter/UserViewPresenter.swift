//
//  UserViewPresenter.swift
//  ??
//
//  Created by Роман on 11.04.2022.
//

import Foundation
import UIKit

protocol UserViewProtocol: AnyObject {
  func moveToProfilePhoto(_ sender: Any)
}

protocol UserViewPresenterProtocol {
  init(view: UserViewProtocol, router: RouterProtocol)
  func moveToProfilePhoto(view: UIViewController)
  func openCamera(view: UIViewController)
  func openDetails(img: Types?, view: UIViewController, index: Int)
}

final class UserViewPresenter: UserViewPresenterProtocol {
  
  //MARK: - Private Properties
  
  private weak var view: UserViewProtocol?
  private let router: RouterProtocol?
  
  //MARK: - Initializers
  
  required init(view: UserViewProtocol, router: RouterProtocol) {
    self.view = view
    self.router = router
  }
  
  //MARK: - Public Methods
  
  public func moveToProfilePhoto(view: UIViewController) {
    
    //        view.navigationController?.pushViewController(profilePhotoVC, animated: true)
  }
  
  public func openCamera(view: UIViewController) {
    router?.openCameraView(view: view)
  }
  
  public func openDetails(img: Types?, view: UIViewController, index: Int) {
    router?.moveToDetailedController(img: img, view: view, index: index)
  }
  
}
