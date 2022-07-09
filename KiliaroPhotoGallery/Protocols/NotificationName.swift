//
//  NotificationName.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/10/22.
//

import Foundation

protocol NotificationName {
    var name: Notification.Name { get }
}

extension RawRepresentable where RawValue == String, Self: NotificationName {
    var name: Notification.Name {
        return Notification.Name(rawValue)
    }
}
