//
//  DateUtil.swift
//  Habita
//
//  Created by Seif Abu El-Ela on 12/1/24.
//

import Foundation

class DateUtil {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
}
