//
//  Endpoint.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import Foundation

struct Endpoint {
    var basePath: String
    var path: String
    var queryItems: [String: Any] = [:]
}

extension Endpoint {
    static let shared = "/shared"


    var url: URL {
        var component = URLComponents()
        component.scheme = ConfigurationUrl.shared.scheme
        component.host = ConfigurationUrl.shared.host
        component.path = basePath + path

        var parameters: [URLQueryItem] = []

        queryItems.forEach { (item: (key: AnyHashable, value: Any)) in
            if item.value is [UInt64] {
                (item.value as! [UInt64]).forEach({ (int) in
                    parameters.append(URLQueryItem(name: "\(item.key)" + "[]", value: "\(int)"))
                })
            } else {
                parameters.append(URLQueryItem(name: "\(item.key)", value: "\(item.value)"))
            }
        }

        component.queryItems?.forEach({ (item) in
            parameters.append(item)
        })

        if parameters != [] {
            component.queryItems = parameters
        }

        /// To decode URL string and remove percent in url
        guard let componentsUrl = component.url,
              let decodeUrl = componentsUrl.absoluteString.removingPercentEncoding,
              let url = URL(string: decodeUrl)
        else {
            preconditionFailure("Invalid URL components: \(component)")
        }

        return url
    }

    var headers: [String: Any] {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
}
