//
//  SystemServices.swift
//  iDine
//
//  Created by Michael Long on 10/5/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

struct SystemServices: ViewModifier {

    static var appState: AppState = AppState()
    static var menu = MenuService()
    static var messages = MessageService()
    static var favorites = FavoritesService()
    static var ratings = RatingsService()
    static var order = Order()

    func body(content: Content) -> some View {
        content
            // defaults
            .accentColor(.red)
            // messages
            .overlay(MessageOverlayView(), alignment: .top)
            // services
            .environmentObject(Self.appState)
            .environmentObject(Self.menu)
            .environmentObject(Self.messages)
            .environmentObject(Self.favorites)
            .environmentObject(Self.order)
            .environmentObject(Self.ratings)
    }

}
