//
//  NetworkService.swift
//  wq
//
//  Created by Роман on 13.01.2022.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol {
  func request(searchTerm: String) async throws -> [Results]
}

actor NetworkService: NetworkServiceProtocol {
  
  func request(searchTerm: String) async throws -> [Results] {
    let params = self.prepareParams(searchTerm: searchTerm)
    let url = self.url(params: params)
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = prepareHeader()
    request.httpMethod = "get"
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
      throw URLError(.badServerResponse)
    }
    
    let results = try JSONDecoder().decode(APIResponse.self, from: data)
    
    return results.results
  }
  
  private func prepareHeader() -> [String: String]? {
    var header = [String: String]()
    header["Authorization"] = "Client-ID B6t55eM4dZgKE92XOx4-kY_dXLeUjx1mdqYUHjdjKfY"
    return header
  }
  
  private func prepareParams(searchTerm: String?) -> [String: String] {
    var params = [String: String]()
    params["query"] = searchTerm
    params["page"] = String(1)
    params["per_page"] = String(31)
    return params
  }
  
  private func url(params: [String: String]) -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.unsplash.com"
    components.path = "/search/photos"
    components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
    guard let componetsUrlUnwrap = components.url else { return URL(fileURLWithPath: " ") }
    return componetsUrlUnwrap
  }
  
}



