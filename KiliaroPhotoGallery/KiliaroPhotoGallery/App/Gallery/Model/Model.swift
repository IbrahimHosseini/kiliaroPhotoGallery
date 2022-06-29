//
//  Model.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import Foundation

struct Media: Codable {
    let id: String?
    let userId: String?
    let mediaType: MediaType?
    let filename: String?
    let size: Int?
    let createdAt: String?
    let takenAt: String?
    let guessedTakenAt: String?
    let md5sum: String?
    let contentType: String?
    let video: Video?
    let thumbnailUrl: String?
    let downloadUrl: String?
    let resX: Int?
    let resY: Int?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case mediaType = "media_type"
        case createdAt = "created_at"
        case takenAt = "taken_at"
        case guessedTakenAt = "guessed_taken_at"
        case contentType = "content_type"
        case thumbnailUrl = "thumbnail_url"
        case downloadUrl = "download_url"
        case resX = "resx"
        case resY = "resy"

        case id
        case filename
        case size
        case md5sum
        case video
    }
}

enum MediaType: String, Codable {
    case image, video
}

struct Video: Codable {
    var id: String?
}
