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
    var index: Int? { get set }
    init(view: DetailedViewProtocol, img: Types, router: RouterProtocol, index: Int)
    func setImg()
}

class DetailedViewPresenter: DetailedViewPresenterProtocol {
    
    var index: Int?
    var view: DetailedViewProtocol?
    var router: RouterProtocol?
    var img: Types

    required init(view: DetailedViewProtocol, img: Types, router: RouterProtocol, index: Int) {
        self.view = view
        self.router = router
        self.img = img
        self.index = index
    }
    
    func setImg() {
        self.view?.setImg(img: img, index: index ?? Int())
    }
    
}
