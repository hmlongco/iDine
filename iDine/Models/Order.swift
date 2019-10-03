//
//  Order.swift
//  iDine
//
//  Created by Paul Hudson on 27/06/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import SwiftUI

class Order: ObservableObject {
    
    @Published var items = [MenuItem]()

    var total: Int {
        items.reduce(0) { $0 + $1.price }
    }

    func totalWithTip(_ tip: Double) -> Double {
        let total = Double(self.total)
        return total + (total * (tip / 100.0))
    }

    func formattedTotalWithTip(_ tip: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total = totalWithTip(tip)
        let result = formatter.string(from: NSNumber(value: total)) ?? "0.00"
        return result
    }

    func ordered(_ menuItem: MenuItem) -> Bool {
        items.firstIndex(where: { $0.id == menuItem.id }) != nil
    }

    func add(item: MenuItem) {
        items.append(item)
    }

    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}
