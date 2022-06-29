//
//  GalleryViewModel.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import Foundation
import Combine

class GalleryViewModel {
    @Published var gallery: [GalleryCollectionViewModel]? = []

    private var service: SharedMediaService

    private var cancellable = Set<AnyCancellable>()

    init() {
        let network = NetworkController()
        service = SharedMediaService(network: network)
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

                self.gallery = response
                    .map { elements -> [GalleryCollectionViewModel]? in
                        var data: [GalleryCollectionViewModel] = []
                        elements.forEach { media in
                            data.append(GalleryCollectionViewModel(media))
                        }
                        return data
                    }!
            }
            .store(in: &cancellable)
    }
}
