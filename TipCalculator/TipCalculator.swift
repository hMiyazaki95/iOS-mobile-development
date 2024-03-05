//
//  TipCalculator.swift
//  TipCalculator
//
//  Created by Hajime Miyazaki on 2/12/24.
//

import Foundation
struct TipCalculator {
    var tipRatio: Double = 0.2
    
    var tipPercent: Double{
        return tipRatio * 100
    }
    func calculateTip(for value: Double) -> Double {
        return tipRatio * value
    }
}
