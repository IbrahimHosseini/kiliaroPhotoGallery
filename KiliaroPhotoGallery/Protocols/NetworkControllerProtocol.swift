//
//  NetworkControllerProtocol.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/10/22.
//

import Foundation
import Combine

protocol NetworkControllerProtocol {
    typealias headers = [String: Any]

    func get<T>(type: T.Type,
                url: URL,
                headers: headers) -> AnyPublisher<T, Error> where T: Decodable
}
