//
//  Numeric+Extension.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 09/11/23.
//

import Foundation

extension Numeric {
    func toCurrencyString(maximumFractionDigits: Int = 2) -> String? {
        guard let displayString = toDisplayString(maximumFractionDigits: maximumFractionDigits) else { return nil }
        let currencySuffix = " €"
        return displayString + currencySuffix
    }
    
    func toDisplayString(maximumFractionDigits: Int = 2) -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.minimumFractionDigits = 0
        return formatter.string(for: self)
    }
}
