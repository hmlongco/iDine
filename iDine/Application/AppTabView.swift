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
    @EnvironmentObject var favorites: FavoritesService
    @EnvironmentObject var messages: MessageService
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

//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    self.messages.show(message: "This is a message! Short but informative!")
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                    self.messages.show(error: "This is an error! You have no idea how much of an error this could be!")
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//                    self.messages.show(error: "This is another error! I warned you!")
//                }
//            }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
            .modifier(SystemServices())
    }
}
