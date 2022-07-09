//
//  MediaCacheHandler.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/10/22.
//

import Foundation
import Cache

class MediaCacheHandler: CacheHandlerInterface {

    typealias StorageType = [Media]

    var storage: Storage<String, [Media]>?

    init() {
        setStorage()
    }

    func setStorage() {
        storage = try? Storage<String, [Media]>(
            diskConfig: self.diskConfig,
            memoryConfig: self.memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: [Media].self)
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

    func save(content: [Media],
              forKey: String) {
        guard let storage = storage else { return }

        do {
            try storage.setObject(content, forKey: forKey)
        } catch {
            print("error")
        }
    }

    func load(with id: String,
              completion: @escaping ([Media]?) -> Void) {
        guard let storage = storage else {
            completion(nil)
            return
        }
        storage.async.object(forKey: id) { result in
            switch result {
            case .value(let media):
                completion(media)
            case .error:
                completion(nil)
            }
        }
    }
}
