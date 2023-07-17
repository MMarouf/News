//
//  Date+Extension.swift
//  News
//
//  Created by Mohamed Marouf on 17/07/2023.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
