//
//  UICollection+dequeue.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import UIKit

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as! T
    }

    func dequeueReusableView<T: UICollectionReusableView>(_ cell: T.Type, ofKind kind: String, indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: cell), for: indexPath) as! T
    }
}

