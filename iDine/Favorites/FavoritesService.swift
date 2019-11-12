//
//  FavoritesService.swift
//  iDine
//
//  Created by Michael Long on 9/22/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import Foundation
import Combine

class FavoritesService: ObservableObject {

    @Published var items: [MenuItem] = []

    var isEmpty: Bool {
        items.isEmpty
    }
    
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

//class FavoritesService: ObservableObject {
//
//    @Published var items: [MenuItem] = []
//
//    private let data = FavoritesData()
//    private var cancellable: AnyCancellable?
//
//    var isEmpty: Bool {
//        items.isEmpty
//    }
//
//    func isFavorite(_ menuItem: MenuItem) -> Bool {
//        items.firstIndex(where: { $0.id == menuItem.id }) != nil
//    }
//
//    func toggleFavorite(_ menuItem: MenuItem) {
//        if let index = items.firstIndex(where: { $0.id == menuItem.id }) {
//            items.remove(at: index)
//        } else {
//            items.append(menuItem)
//        }
//        data.update(items)
//    }
//
//    func load() {
//        cancellable = data.load()
//            .assign(to: \.items, on: self)
//    }
//
//}
//
//class FavoritesData {
//    func load() -> AnyPublisher<[MenuItem], Never> {
//        Just<[MenuItem]>([]).eraseToAnyPublisher()
//    }
//    func update(_ items: [MenuItem]) {
//
//    }
//}
