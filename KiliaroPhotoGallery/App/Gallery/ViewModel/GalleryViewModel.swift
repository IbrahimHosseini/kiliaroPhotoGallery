//
//  GalleryViewModel.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import Foundation
import Combine

protocol GalleryViewModelInterface {
    var galleryPublisher: PassthroughSubject<[GalleryCollectionViewModel]?, Never> { get }

    func getSharedMedia(_ sharedKey: String)
    func removeAllMedia()
}

class GalleryViewModel: GalleryViewModelInterface {
    var galleryPublisher = PassthroughSubject<[GalleryCollectionViewModel]?, Never>()

    private let cacheHandler = MediaCacheHandler()

    private var service: SharedMediaProtocol

    private var cancellable = Set<AnyCancellable>()

    init(service: SharedMediaProtocol) {
        self.service = service
    }

    // MARK: Methods
    fileprivate func saveMediaToCache(_ response: [Media], forKey: String) {
        cacheHandler.save(content: response,
                           forKey: forKey)
    }

    fileprivate func getMediaFromServer(_ sharedKey: String) {
        service.getSharedMedia(sharedKey)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Finished get media")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                let data = response
                    .map { elements -> [GalleryCollectionViewModel]? in
                        var data: [GalleryCollectionViewModel] = []
                        elements.forEach { media in
                            data.append(GalleryCollectionViewModel(media))
                        }
                        return data
                    }!
                self.galleryPublisher.send(data)
                if let response = response {
                    self.saveMediaToCache(response,
                                          forKey: sharedKey)
                }
            }
            .store(in: &cancellable)
    }

    func getSharedMedia(_ sharedKey: String) {
        cacheHandler.load(with: sharedKey) { [weak self] media in
            let data = media
                .map { elements -> [GalleryCollectionViewModel] in
                    var dataGallery: [GalleryCollectionViewModel] = []
                    elements.forEach { media in
                        dataGallery.append(GalleryCollectionViewModel(media))
                    }
                    return dataGallery
                }

            guard let data = data else {
                self?.getMediaFromServer(sharedKey)
                return
            }
            self?.galleryPublisher.send(data)
        }
    }

    func removeAllMedia() {
        cacheHandler.removeAll()
    }
}
