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
        guard let url = url else { return }
        setImage(urlString: url,
                 placeholderImage: placeholderImageName)
    }

    public func setImage(urlString: String,
                         placeholderImage: UIImage = UIImage(named: "appLogo")!) {

        load(image: urlString) { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            }
        }

        guard let url = URL(string: urlString) else {
            self.image = placeholderImage
            return
        }

        self.kf.indicatorType = .activity

        KF.url(url)
            .placeholder(placeholderImage)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .keepCurrentImageWhileLoading()
            .cacheOriginalImage()
            .fade(duration: 0.25)
            .onSuccess { result in
                self.save(image: result.image,
                          forKey: url.absoluteString)
            }
            .onFailure { error in }
            .set(to: self)
    }

    deinit {
        self.kf.cancelDownloadTask()
    }

    private func save(image: UIImage,
                      forKey: String) {
        CacheHandler.shared
            .save(image: image,
                  forKey: forKey)
    }

    private func load(image fromUrl: String,
                      completion: @escaping (UIImage?) -> Void) {
        CacheHandler.shared
            .load(image: fromUrl) { image in
                completion(image)
            }
    }
}

