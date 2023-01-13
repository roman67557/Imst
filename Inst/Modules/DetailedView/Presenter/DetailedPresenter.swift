//
//  DetailedPresenter.swift
//  wq
//
//  Created by Роман on 03.02.2022.
//

import Foundation
import UIKit

protocol DetailedViewProtocol: AnyObject {
  func setImg(img: Types?, index: Int)
}

protocol DetailedViewPresenterProtocol: AnyObject {
  init(view: DetailedViewProtocol, img: Types, router: RouterProtocol, index: Int)
  func setImg()
  func openAlert(error: String)
}

final class DetailedViewPresenter: DetailedViewPresenterProtocol {
  
  //MARK: - Private Properties
  
  private var index: Int?
  private weak var view: DetailedViewProtocol?
  private var router: RouterProtocol?
  private var img: Types
  
  //MARK: - Initializers
  
  required init(view: DetailedViewProtocol, img: Types, router: RouterProtocol, index: Int) {
    self.view = view
    self.router = router
    self.img = img
    self.index = index
  }
  
  //MARK: - Public Methods
  
  public func setImg() {
    self.view?.setImg(img: img, index: index ?? Int())
  }
  
  public func openAlert(error: String) {
    guard let vc = view as? UIViewController else { return }
    router?.openAlert(view: vc, error: error)
  }
  
}
