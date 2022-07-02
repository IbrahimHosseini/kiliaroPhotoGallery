//
//  String+Date.swift
//  KiliaroPhotoGallery
//
//  Created by Ibrahim Hosseini on 7/2/22.
//

import Foundation

class DateTime {
    class func date(_ date: String) -> String {

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        let date: Date? = dateFormatterGet.date(from: date)
        return dateFormatterPrint.string(from: date!);
    }
}

extension String {
    var toDate: String {
        return DateTime.date(self)
    }
}
