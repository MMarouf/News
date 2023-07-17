//
//  WebService.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case invalidJson
    case badRequest
    case serverError
    case offlineConnection
    case unknown
}

private enum StatusCode {
    static let success = 200...299
    static let badRequest = 400...499
    static let serverError = 500...599
}

protocol WebService {
    func fetch<T: Decodable>(endpoint: Endpoint) async -> Result<T, APIError>
}

extension WebService {
    func fetch<T: Decodable>(endpoint: Endpoint) async -> Result<T, APIError> {
        let urlRequest = URLRequest(url: endpoint.finalURL)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            //   let str = String(decoding: data, as: UTF8.self)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            switch httpResponse.statusCode {
            case 200...299:
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    throw APIError.invalidJson
                }
                return .success(decodedData)
            case 400...499:
                throw APIError.badRequest
            case 500...599:
                throw APIError.serverError
            default:
                throw APIError.unknown
            }
        } catch {
            if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                print("no internet connection")
            }
            print(error)
            return .failure(APIError.offlineConnection)
        }
}
}
