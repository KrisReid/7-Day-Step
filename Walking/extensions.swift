//
//  extensions.swift
//  Walking
//
//  Created by Kris Reid on 24/11/2020.
//

import Foundation

extension Date {
    static func mondyAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}
