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
}

class GalleryViewModel: GalleryViewModelInterface {
    var galleryPublisher = PassthroughSubject<[GalleryCollectionViewModel]?, Never>()

    private var service: SharedMediaProtocol

    private var cancellable = Set<AnyCancellable>()

    init(service: SharedMediaProtocol) {
        self.service = service
    }

    // MARK: Methods
    func getSharedMedia(_ sharedKey: String) {
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
            }
            .store(in: &cancellable)
    }
}
