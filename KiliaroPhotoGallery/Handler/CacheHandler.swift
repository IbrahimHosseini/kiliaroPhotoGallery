//
//  CacheHandler.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/2/22.
//

import Foundation
import Cache
import UIKit

protocol CacheHandlerInterface {
    func set(diskConfig: DiskConfig)
    func set(memoryConfig: MemoryConfig)

    func save(object: [Media])
}

class CacheHandler {
    static let shared = CacheHandler()

    private init() {
        setStorage()
        setStorageImage()
    }

    private var diskConfig = DiskConfig(name: "sharedMedia")
    private var memoryConfig = MemoryConfig(expiry: .never,
                                            countLimit: 500,
                                            totalCostLimit: 0)

    private var storage: Storage<String, [Media]>?
    private var storageImage: Storage<String, UIImage>?

    func set(diskConfig: DiskConfig) -> Self {
        self.diskConfig = diskConfig
        return self
    }

    func set(memoryConfig: MemoryConfig) -> Self {
        self.memoryConfig = memoryConfig
        return self
    }

    func removeAll() {
        guard let storage = storage,
              let storageImage = storageImage
        else { return }

        do {
            try storage.removeAll()
            try storageImage.removeAll()
            print("remove all data")
        } catch {
            print(error)
        }

    }

    // MARK: - Store media
    private func setStorageImage() {
        storageImage = try? Storage<String, UIImage>(diskConfig: diskConfig,
                                                     memoryConfig: memoryConfig,
                                                     transformer: TransformerFactory.forImage())
    }

    func save(object: [Media]) {
        let key = Constants.sharedKey
        guard let storage = storage else {
            return
        }

        do {
            try storage.setObject(object, forKey: key)
        } catch {
            print("error")
        }
    }

    func load(object withId: String, completion: @escaping ([Media]?) -> Void) {
        guard let storage = storage else {
            completion(nil)
            return
        }

        storage.async.object(forKey: withId) { result in
            switch result {
            case .value(let media):
                completion(media)
            case .error:
                completion(nil)
            }
        }
    }

    // MARK: - Store image
    private func setStorage() {
        storage = try? Storage<String, [Media]>(
            diskConfig: self.diskConfig,
            memoryConfig: self.memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: [Media].self)
        )
    }

    func save(image: UIImage, forKey: String) {
        guard let storageImage = storageImage else {
            return
        }

        do {
            try storageImage.setObject(image, forKey: forKey)
        } catch {
            print("error")
        }
    }

    func load(image withKey: String, completion: @escaping (UIImage?) -> Void) {
        guard let storageImage = storageImage else {
            completion(nil)
            return
        }
        storageImage.async.object(forKey: withKey) { result in
            switch result {
            case .value(let image):
                completion(image)
            case .error:
                completion(nil)
            }
        }
    }

}
