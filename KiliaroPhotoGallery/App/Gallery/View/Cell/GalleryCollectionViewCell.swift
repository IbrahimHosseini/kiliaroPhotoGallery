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
        
        imageView.setImage(urlString: isFullScreen ? viewModel.downloadUrl : viewModel.thumbnailUrl)

        if isFullScreen {
            dateLabel.isHidden = false
        }
        dateLabel.text = viewModel.createdAt
    }

}
