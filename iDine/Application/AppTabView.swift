//
//  AppTabView.swift
//  iDine
//
//  Created by Michael Long on 9/19/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

struct AppTabView: View {

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var order: Order

    var orderText: String {
        if order.items.isEmpty {
            return "Order"
        } else {
            return "Order - \(order.items.count)"
        }
    }

    var body: some View {
        TabView(selection: $appState.currentTab) {
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                        .scaleEffect(1.5)
                    Text("Favorites")
                    }
                .tag(AppTabs.favorites)
            MainMenuView()
                .tabItem {
                    Image(systemName: "list.dash")
                        .scaleEffect(1.5)
                    Text("Menu")
                    }
                .tag(AppTabs.menu)
            OrderView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                        .scaleEffect(1.5)
                    Text(orderText)
                    }
                .tag(AppTabs.order)
            }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .modifier(SystemServices())
    }
}
