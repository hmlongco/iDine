//
//  MainMenuView.swift
//  iDine
//
//  Created by Michael Long on 9/19/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

struct MainMenuView: View {

    @EnvironmentObject var menu: MenuService

    var body: some View {
        NavigationView {
            List {
                ForEach(menu.sections) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.items) { item in
                            MainMenuRow(item: item)
                        }
                    }
                }
            }
            .onAppear(perform: {
                if self.menu.sections.isEmpty {
                    self.menu.load()
                }
            })
            .navigationBarTitle("iDine Menu")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
            .environmentObject(AppState())
    }
}
