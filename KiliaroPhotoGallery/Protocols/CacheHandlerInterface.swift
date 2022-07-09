//
//  CacheHandlerInterface.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/10/22.
//

import Foundation
import Cache

protocol CacheHandlerInterface {
    associatedtype StorageType

    var diskConfig: DiskConfig { get }
    var memoryConfig: MemoryConfig { get set }
    var storage: Storage<String, StorageType>? { get set }

    func removeAll()
    func setStorage()
    func save(content: StorageType, forKey: String)
    func load(with id: String, completion: @escaping (StorageType?) -> Void)
}

extension CacheHandlerInterface {

    var diskConfig: DiskConfig {
        get {
            return DiskConfig(name: "sharedMedia")
        }
    }

    var memoryConfig: MemoryConfig {
        get {
            return MemoryConfig(expiry: .never,
                                countLimit: 500,
                                totalCostLimit: 0)
        }

        set {
            memoryConfig = newValue
        }
    }

}
