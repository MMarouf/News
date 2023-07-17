//
//  EndPoint.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: [String: Any]? { get }
}

extension Endpoint {
    var finalURL: URL {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = "\(baseURL.path)/\(path)"
        components.queryItems = !(queryItems?.isEmpty ?? false) ? queryItems : nil
        return components.url!
    }
}

enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
