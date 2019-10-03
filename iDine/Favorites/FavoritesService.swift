//
//  FavoriteService.swift
//  iDine
//
//  Created by Michael Long on 9/22/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import Foundation

class FavoriteService: ObservableObject {

    @Published var items: [MenuItem] = []

    func isFavorite(_ menuItem: MenuItem) -> Bool {
        items.firstIndex(where: { $0.id == menuItem.id }) != nil
    }

    func toggleFavorite(_ menuItem: MenuItem) {
        if let index = items.firstIndex(where: { $0.id == menuItem.id }) {
            items.remove(at: index)
        } else {
            items.append(menuItem)
        }
    }

}
