//
//  Menu.swift
//  iDine
//
//  Created by Paul Hudson on 27/06/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import SwiftUI

class MenuService: ObservableObject {

    @Published var sections: [MenuSection] = []

    func load() {
        sections = Bundle.main.decode([MenuSection].self, from: "menu.json")
    }

}

struct MenuSection: Codable, Identifiable {

    var id: UUID
    var name: String
    var items: [MenuItem]

}

struct MenuItem: Codable, Equatable, Identifiable {

    var id: UUID
    var name: String
    var photoCredit: String
    var price: Int
    var restrictions: [String]
    var description: String

    var formattedPrice: String {
        "$\(price).00"
    }

    var mainImage: String {
        name.replacingOccurrences(of: " ", with: "-").lowercased()
    }

    var thumbnailImage: String {
        "\(mainImage)-thumb"
    }

    #if DEBUG
    static let example = MenuItem(id: UUID(), name: "Maple French Toast", photoCredit: "Joseph Gonzalez", price: 6, restrictions: ["G", "V"], description: "Sweet, fluffy, and served piping hot, our French toast is flown in fresh every day from Maple City, Canada, which is where all maple syrup in the world comes from. And if you believe that, we have some land to sell you…")
    #endif
}
