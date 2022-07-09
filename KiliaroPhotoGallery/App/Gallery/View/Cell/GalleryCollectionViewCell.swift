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
        guard let viewModel = viewModel else { return }

        let urlString = isFullScreen ? viewModel.downloadUrl : viewModel.thumbnailUrl

        let url = imageUrlHandler(urlString)
        self.imageView.url = url

        dateLabel.isHidden = !isFullScreen

        viewModel.$createdAt
            .map { $0.toDate }
            .assign(to: \.text, on: dateLabel)
            .store(in: &cancellable)
    }

    private func imageUrlHandler(_ url: String) -> String {

        let height = isFullScreen ? Int(UIScreen.main.bounds.height) : 250
        let width = isFullScreen ? Int(UIScreen.main.bounds.width) : 250
        let resizeMode: ResizeMode = isFullScreen ? .bb : .crop

        let imageSize = ImageSizeHandler()
            .set(url: url)
            .set(height: height)
            .set(width: width)
            .set(resize: resizeMode)
            .set(isFullScreen: isFullScreen)

        return imageSize.buildUrl()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

}
