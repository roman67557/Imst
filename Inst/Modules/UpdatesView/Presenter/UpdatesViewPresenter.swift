//
//  UpdatesViewPresenter.swift
//  ??
//
//  Created by Роман on 17.11.2022.
//

import Foundation

protocol UpdatesViewProtocol {
  
}

protocol UpdatesViewPresenterProtocol {
  
}

class UpdatesViewPresenter: UpdatesViewPresenterProtocol {
  
  let view: UpdatesViewProtocol?
  let router: RouterProtocol?
  
  required init(view: UpdatesViewProtocol, router: RouterProtocol) {
      self.view = view
      self.router = router
  }
  
}
