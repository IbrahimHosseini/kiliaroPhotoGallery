//
//  ImageView.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import Foundation
import Kingfisher

class ImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    // MARK: - Helper functions
    private func initView() {
        isOpaque = true
        clipsToBounds = true
    }

    public func setImage(urlString: String, placeholderImage: UIImage? = nil) {

        guard let url = URL(string: urlString) else {
            self.image = placeholderImage
            return
        }

        self.kf.indicatorType = .activity

        KF.url(url)
            .placeholder(placeholderImage)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .cacheOriginalImage()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in  }
            .onFailure { error in }
            .set(to: self)
    }

    deinit {
        self.kf.cancelDownloadTask()
    }
}

