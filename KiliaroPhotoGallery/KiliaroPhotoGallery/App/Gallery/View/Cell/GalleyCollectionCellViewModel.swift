//
//  GalleyCollectionCellViewModel.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import Foundation
import Combine

class GalleryCollectionViewModel {
    @Published var id: String = ""
    @Published var userId: String = ""
    @Published var mediaType: MediaType = .image
    @Published var filename: String = ""
    @Published var size: Int = 0
    @Published var createdAt: String = ""
    @Published var takenAt: String = ""
    @Published var guessedTakenAt: String = ""
    @Published var md5sum: String = ""
    @Published var contentType: String = ""
    @Published var video: Video?
    @Published var thumbnailUrl: String = ""
    @Published var downloadUrl: String = ""
    @Published var resX: Int?
    @Published var resY: Int?

    private var media: Media?

    init(_ media: Media) {
        self.media = media
        setupBinding()
    }

    private func setupBinding() {
        guard let media = media else { return }

        if let id = media.id {
            self.id = id
        }

        if let userId = media.userId {
            self.userId = userId
        }

        if let mediaType = media.mediaType {
            self.mediaType = mediaType
        }

        if let filename = media.filename {
            self.filename = filename
        }

        if let size = media.size {
            self.size = size
        }

        if let createdAt = media.createdAt {
            self.createdAt = createdAt
        }

        if let takenAt = media.takenAt {
            self.takenAt = takenAt
        }

        if let guessedTakenAt = media.guessedTakenAt {
            self.guessedTakenAt = guessedTakenAt
        }

        if let md5sum = media.md5sum {
            self.md5sum = md5sum
        }

        if let contentType = media.contentType {
            self.contentType = contentType
        }

        if let video = media.video {
            self.video = video
        }

        if let thumbnailUrl = media.thumbnailUrl {
            self.thumbnailUrl = thumbnailUrl
        }

        if let downloadUrl = media.downloadUrl {
            self.downloadUrl = downloadUrl
        }

        if let resX = media.resX {
            self.resX = resX
        }

        if let resY = media.resY {
            self.resY = resY
        }
    }

}
