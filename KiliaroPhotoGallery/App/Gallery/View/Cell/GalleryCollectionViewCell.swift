//
//  GalleryCollectionViewCell.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/29/22.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyCollectionViewCell"

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)

        let image: [UIImage] = [UIImage(named: "1"),
                                UIImage(named: "2"),
                                UIImage(named: "3"),
                                UIImage(named: "4"),
                                UIImage(named: "5")].compactMap { $0 }

        imageView.image = image.randomElement()
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}
