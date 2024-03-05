//
//  File.swift
//  TipCalculator
//
//  Created by Hajime Miyazaki on 2/12/24.
//

import Foundation
struct Formatter {
    func formattedCurrency(for value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: value as NSNumber) ?? "\(value) is not a valid currency value"
    }
    func formatPercent(for value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: value as NSNumber) ?? "\(value) is not a valid percentage value"
    }
    func currencySymbol() -> String {
        return Locale.current.currencySymbol ?? ""
    }
}
