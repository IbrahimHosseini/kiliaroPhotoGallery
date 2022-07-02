//
//  UIView+Border.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/1/22.
//

import UIKit

extension UIView {
    func setBorder(color: UIColor, width: CGFloat?) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width ?? layer.borderWidth
    }
}
