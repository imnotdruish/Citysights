//
//  TextHelper.swift
//  Citysights
//
//  Created by Dan June on 6/17/25.
//

import Foundation

struct TextHelper {
    static func distanceAwayText(meters: Double) -> String {
        let miles = meters / 1609.344

        if miles > 1000 {
            return "\(String(format: "%0.2fk", miles/1000)) miles away"
        } else if miles < 0.1 {
            let feet = miles * 5280
            return "\(Int(round(feet))) ft. away"
        } else {
            return "\(String(format: "%0.2f", miles)) miles away"
        }
    }
}
