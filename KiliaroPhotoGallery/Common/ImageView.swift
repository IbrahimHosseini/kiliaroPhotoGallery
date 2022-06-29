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

        self.kf.cancelDownloadTask()
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        self.kf.setImage(with: resource,
                         placeholder: placeholderImage,
                         options: [.transition(.fade(0.25))])
    }

    deinit {
        self.kf.cancelDownloadTask()
    }
}

