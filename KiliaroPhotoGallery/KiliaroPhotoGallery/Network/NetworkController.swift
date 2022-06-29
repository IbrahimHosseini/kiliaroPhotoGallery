//
//  NetworkController.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import Foundation
import Combine

protocol NetworkControllerProtocol {
    typealias headers = [String: Any]

    func get<T>(type: T.Type,
                url: URL,
                headers: headers) -> AnyPublisher<T, Error> where T: Decodable
}

final class NetworkController: NetworkControllerProtocol {
    func get<T>(type: T.Type,
                url: URL,
                headers: headers) -> AnyPublisher<T, Error> where T : Decodable {
        var urlRequest = URLRequest(url: url)

        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }

        return URLSession
            .shared
            .dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
