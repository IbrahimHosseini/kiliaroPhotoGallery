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

    static let identifier = "MyCollectionViewCell"

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
    }

    public func fill(_ data: GalleryCollectionViewModel) {
        self.viewModel = data
    }

    fileprivate func setupBinding() {
        guard let viewModel = viewModel else {
            return
        }
        
        imageView.setImage(urlString: viewModel.thumbnailUrl)
    }

}
