//
//  AppState.swift
//  iDine
//
//  Created by Michael Long on 9/22/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI
import Combine

enum AppTabs: Int {
    case favorites
    case menu
    case order
}

class AppState: ObservableObject {
    @Published var currentTab = AppTabs.favorites
}

//class MockAppState: AppState {
//    override func load() {
//        menu = [MenuSection(id: UUID(), name: "Stuff", items: [MenuItem.example])]
//    }
//}
//
//
//
//
//
//
//class ManualAppState: ObservableObject {
//
//    var currentTab = AppTabs.favorites
//        { willSet {  objectWillChange.send() }  }
//
//    var menu = Bundle.main.decode([MenuSection].self, from: "menu.json")
//        { willSet {  objectWillChange.send() }  }
//
//    var orderPlaced = false
//
//    var objectWillChange = ObservableObjectPublisher()
//
//}
