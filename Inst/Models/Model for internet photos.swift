//
//  Model.swift
//  wq
//
//  Created by Роман on 13.01.2022.
//

import Foundation

struct APIResponse: Codable {
    let total: Int?
    let total_pages: Int?
    var results: [Results]
}

struct Results: Codable {
    let width: Int?
    let height: Int?
    let id: String?
    let urls: URLS
}

struct URLS: Codable {
    let regular: String?
    let thumb: String?
    let full: String?
}

enum Types {
  case results([Results])
  case shooterdImages([ShooterdImages])
}



