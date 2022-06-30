//
//  ImageSizeHandler.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import Foundation

class ImageSizeHandler {
    private var height = 250
    private var width = 250
    private var resizeMode: ResizeMode = .crop
    private var url = ""
    private var isFullScreen = false

    func setUrl(_ url: String) -> ImageSizeHandler {
        self.url = url
        return self
    }

    func setResizeMode(_ mode: ResizeMode) -> ImageSizeHandler {
        self.resizeMode = mode
        return self
    }

    func setHeight(_ height: Int) -> ImageSizeHandler {
        self.height = height
        return self
    }

    func setWidth(_ width: Int) -> Self {
        self.width = width
        return self
    }

    func setIsFullScreen(_ isFullScreen: Bool) -> ImageSizeHandler {
        self.isFullScreen = isFullScreen
        return self
    }

    func buildUrl() -> String {
        return "\(url)?h=\(height)&w=\(width)&m=\(resizeMode)"
    }
}

enum ResizeMode: String {
    case bb
    case md
    case crop
}
