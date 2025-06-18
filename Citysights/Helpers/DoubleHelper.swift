//
//  DoubleHelper.swift
//  Citysights
//
//  Created by Dan June on 6/17/25.
//

import Foundation

extension Double {
    func round(nearest: Double) -> Double {
        let n = 1 / nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
}

func roundedNum(num: Double) -> Double {
    let roundNum = num.round(nearest: 0.5)
    return roundNum
}
