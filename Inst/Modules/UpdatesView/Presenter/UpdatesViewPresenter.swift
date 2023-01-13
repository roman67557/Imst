//
//  UpdatesViewPresenter.swift
//  ??
//
//  Created by Роман on 17.11.2022.
//

import Foundation

protocol UpdatesViewProtocol: AnyObject {
  
}

protocol UpdatesViewPresenterProtocol {
  
}

final class UpdatesViewPresenter: UpdatesViewPresenterProtocol {
  
  //MARK: - Private Properties
  
  private weak var view: UpdatesViewProtocol?
  private let router: RouterProtocol?
  
  //MARK: - Initializers
  
  required init(view: UpdatesViewProtocol, router: RouterProtocol) {
      self.view = view
      self.router = router
  }
  
}
