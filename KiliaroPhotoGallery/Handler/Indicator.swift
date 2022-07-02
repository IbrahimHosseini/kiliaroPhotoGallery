//
//  Indicator.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/2/22.
//

import Foundation
import SPIndicator

class Indicator {
    class func done(title: String) {
        SPIndicator.present(title: title,
                            preset: .done,
                            haptic: .success)
    }

    class func error(title: String) {
        SPIndicator.present(title: title,
                            preset: .error,
                            haptic: .error)
    }
}
