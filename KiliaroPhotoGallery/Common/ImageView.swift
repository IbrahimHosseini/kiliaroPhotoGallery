//
//  ImageView.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import Foundation
import Kingfisher

class ImageView: UIImageView {

    private let cacheHandler = ImageCacheHandler()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }

    var url: String? {
        didSet {
            setImage()
        }
    }

    var placeholderImageName: UIImage = UIImage(named: "appLogo")! {
        didSet {
            setImage()
        }
    }

    // MARK: - Helper functions
    private func initView() {
        isOpaque = true
        clipsToBounds = true
    }

    private func setImage() {
        guard let url = self.url else { return }
        load(image: url) { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            }
        }

        guard let url = URL(string: url) else {
            self.image = placeholderImageName
            return
        }

        self.kf.indicatorType = .activity

        KF.url(url)
            .placeholder(placeholderImageName)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .keepCurrentImageWhileLoading()
            .cacheOriginalImage()
            .fade(duration: 0.25)
            .onSuccess { result in
                self.save(image: result.image,
                          forKey: url.absoluteString)
            }
            .progressiveJPEG()
            .onFailure { error in }
            .set(to: self)
    }

    deinit {
        self.kf.cancelDownloadTask()
    }

    private func save(image: UIImage,
                      forKey: String) {
        cacheHandler.save(content: image,
                          forKey: forKey)
    }

    private func load(image fromUrl: String,
                      completion: @escaping (UIImage?) -> Void) {
        cacheHandler.load(with: fromUrl) { image in
            completion(image)
        }
    }
}

