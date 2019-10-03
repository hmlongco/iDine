//
//  FavoritesView.swift
//  iDine
//
//  Created by Michael Long on 9/22/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var favorites: FavoriteService
    @EnvironmentObject var menu: MenuService

    var body: some View {
        NavigationView {
            List {
                if favorites.items.isEmpty {
                    Text("No favorites selected. May we suggest?")
                        .foregroundColor(.secondary)
                    if menu.sections.count > 2 {
                        MainMenuRow(item: menu.sections[0].items[0])
                        MainMenuRow(item: menu.sections[1].items[2])
                        MainMenuRow(item: menu.sections[2].items[2])
                    }
                } else {
                    ForEach(favorites.items) { item in
                        MainMenuRow(item: item)
                    }
                }
            }
            .onAppear(perform: {
                self.menu.load()
            })
            .navigationBarTitle("iDine Favorites")
        }
    }

}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(AppState())
            .environmentObject(FavoriteService())
    }
}
