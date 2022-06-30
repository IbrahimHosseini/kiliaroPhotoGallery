//
//  GalleryCollectionViewCell.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import UIKit
import Combine

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: ImageView!
    @IBOutlet weak var dateLabel: UILabel!

    static let identifier = "MyCollectionViewCell"

    private var isFullScreen = false

    private var cancellable = Set<AnyCancellable>()

    private var viewModel: GalleryCollectionViewModel? {
        didSet {
            setupBinding()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        let radius = UIScreen.main.bounds.width * 0.00
        imageView.setCornerRadius(radius)

        dateLabel.text = ""
        dateLabel.isHidden = true
        dateLabel.textColor = .systemGray2
        dateLabel.font = .systemFont(ofSize: 14,
                                     weight: .semibold)
    }

    public func fill(_ data: GalleryCollectionViewModel, isFullScreen: Bool = false) {
        self.isFullScreen = isFullScreen
        self.viewModel = data

    }

    fileprivate func setupBinding() {
        guard let viewModel = viewModel else {
            return
        }
        let url = imageUrl()
        print("URL-> \(url)")
        imageView.setImage(urlString: url)

        if isFullScreen {
            dateLabel.isHidden = false
        }
        dateLabel.text = viewModel.createdAt
    }

    private func imageUrl() -> String {

        guard let viewModel = viewModel else {
            return ""
        }

        let height = isFullScreen ? Int(UIScreen.main.bounds.height) : 250//Int(self.contentView.bounds.height)
        let width = isFullScreen ? Int(UIScreen.main.bounds.width) : 250//Int(self.contentView.bounds.width)
        let resizeMode: ResizeMode = isFullScreen ? .bb : .crop
        let url = isFullScreen ? viewModel.downloadUrl : viewModel.thumbnailUrl

        let imageSize = ImageSizeHandler()
            .setUrl(url)
            .setHeight(height)
            .setWidth(width)
            .setResizeMode(resizeMode)
            .setIsFullScreen(isFullScreen)

        return imageSize.buildUrl()
    }

}
