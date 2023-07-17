//
//  String+Extension.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation

extension String {
    func stringToDate() -> Date {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate] // Added format options
        let date = dateFormatter.date(from: self) ?? Date.now
        return date
    }
}
