//
//  ConfigurationUrl.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import Foundation

class ConfigurationUrl {
    static let shared = ConfigurationUrl()
    
    var scheme : String
    var host: String

    private init() {
        if let dictionary = Bundle.main.infoDictionary,
           let configuration = dictionary["Configuration"] as? String {
            let path = Bundle.main.path(forResource: "Configuration", ofType: "plist")
            let config = NSDictionary(contentsOfFile: path!)
            for (key, value) in config! {
                if let key = key as? String,
                   let value = value as? [String: Any] {
                    if key == configuration {
                        scheme  = value["scheme"] as? String ?? ""
                        host  = value["host"]  as? String ?? ""

                        return
                    }
                }
            }
        }
        fatalError("Error: Configuration file doesn't exist in project directory, please include it to be able to use this class")
    }
}
