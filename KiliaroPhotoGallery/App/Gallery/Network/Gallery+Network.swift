//
//  Gallery+Network.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import Foundation
import Combine

extension Endpoint {
    static private let media = "media"

    static func getSharedMedia(_ sharedKey: String) -> Self {
        let path = "/" + sharedKey + "/" + media

        return Endpoint(basePath: shared, path: path)
    }
}

//MARK: - Logic Controller
protocol SharedMediaProtocol: ServiceProtocol {
    func getSharedMedia(_ sharedKey: String) -> AnyPublisher<[Media]?, Error>
}

final class SharedMediaService: SharedMediaProtocol {
    var networkController: NetworkControllerProtocol

    init(network: NetworkControllerProtocol) {
        self.networkController = network
    }

    func getSharedMedia(_ sharedKey: String) -> AnyPublisher<[Media]?, Error> {
        let endpoint = Endpoint.getSharedMedia(sharedKey)

        return networkController.get(type: [Media]?.self,
                                     url: endpoint.url,
                                     headers: endpoint.headers)
    }
}
