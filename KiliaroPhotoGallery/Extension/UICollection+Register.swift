//
//  UICollection+Register.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import UIKit

extension UICollectionView {
    /// Register cells with nib file
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: String(describing: cell), bundle: nil),
                      forCellWithReuseIdentifier: String(describing: cell))
    }

    func registerReusableView<T: UICollectionReusableView>(_ cell: T.Type, ofKind: String) {
        self.register(cell,
                      forSupplementaryViewOfKind: ofKind,
                      withReuseIdentifier: String(describing: cell))
    }
}
