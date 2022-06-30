//
//  UIStoryboard+instantiation.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 6/30/22.
//

import UIKit

extension UIStoryboard {
    func instantiate<T: UIViewController>(viewController: T.Type) -> T {
        return self.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
