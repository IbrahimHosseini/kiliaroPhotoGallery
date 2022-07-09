//
//  ImageCacheHandler.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/2/22.
//

import Foundation
import Cache
import UIKit

class ImageCacheHandler: CacheHandlerInterface {

    typealias StorageType = UIImage

    var storage: Storage<String, UIImage>?

    init() {
        setStorage()
    }

    func setStorage() {
        storage = try? Storage<String, UIImage>(
            diskConfig: self.diskConfig,
            memoryConfig: self.memoryConfig,
            transformer: TransformerFactory.forImage()
        )
    }

    func removeAll() {
        guard let storage = storage else { return }

        do {
            try storage.removeAll()
            print("remove all data")
        } catch {
            print(error)
        }
    }

    func save(content: UIImage,
              forKey: String) {
        guard let storage = storage else { return }

        do {
            try storage.setObject(content, forKey: forKey)
        } catch {
            print("error")
        }
    }

    func load(with id: String,
              completion: @escaping (UIImage?) -> Void) {
        guard let storage = storage else {
            completion(nil)
            return
        }
        storage.async.object(forKey: id) { result in
            switch result {
            case .value(let image):
                completion(image)
            case .error:
                completion(nil)
            }
        }
    }
}
