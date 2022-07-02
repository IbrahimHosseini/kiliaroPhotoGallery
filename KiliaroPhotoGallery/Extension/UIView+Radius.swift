//
//  UIView+Radius.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    func setCornerRadius(_ radius: CGFloat = 25, isMask: Bool = true) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = isMask
    }
}
