//
//  FavoritesView.swift
//  iDine
//
//  Created by Michael Long on 9/22/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject var favorites: FavoritesService
    @EnvironmentObject var menu: MenuService

    var body: some View {
        NavigationView {
            List {
                if favorites.isEmpty {
                    if menu.representativeSample.isEmpty {
                        Text("Loading...")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(menu.representativeSample) { item in
                            MainMenuRow(item: item)
                        }
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
        .navigationViewStyle(StackNavigationViewStyle())
    }

}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .modifier(SystemServices())
    }
}
