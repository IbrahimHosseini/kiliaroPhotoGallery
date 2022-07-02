//
//  NotificationNames.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/2/22.
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

enum Notifications {
    enum Reachability: String, NotificationName {
        case connected
        case notConnected
    }
}
