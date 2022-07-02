//
//  UIView+shadow.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/1/22.
//

import UIKit

extension UIView {
    func setShadow(shadowColor: UIColor = .gray,
                   offSet: CGSize = CGSize(width: 0, height: 0),
                   opacity: Float = 0.3,
                   shadowRadius: CGFloat = 5,
                   cornerRadius: CGFloat = 5) {
        
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = offSet
    }
}
