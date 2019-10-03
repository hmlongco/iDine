//
//  DetailView.swift
//  iDine
//
//  Created by Michael Long on 9/19/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

struct DetailView2: View {

    @EnvironmentObject var favorites: FavoriteService
    @EnvironmentObject var order: Order

    let item: MenuItem

    var body: some View {
        VStack {
            Image(item.mainImage)
                .overlay(PhotoCredit(text: item.photoCredit).offset(x: -5, y: -5), alignment: .bottomTrailing)
                .saturation(1.25)

            HStack {
                if order.ordered(item) {
                    Text("√")
                        .font(.footnote)
                }
                Text(item.name)
                    .font(.headline)
                    .layoutPriority(1)
                Spacer()
                ItemRestrictionView(restrictions: item.restrictions)
                }
                .animation(.default)
                .padding()

            Text(item.description)
                .layoutPriority(1)
                .padding([.leading, .trailing])

            HStack {
                Spacer()
                Text(item.formattedPrice)
                    .bold()
                }
                .padding()

            Button(order.ordered(item) ? "Add Another One" : "Add To Order") { self.orderNow() }
                    .font(.headline)
                    .padding()
                    .animation(.default)

            Spacer()
        }
        .navigationBarTitle("Details", displayMode: .inline)
        .navigationBarItems(trailing: Image(systemName: favorites.isFavorite(item) ? "star.fill" : "star")
            .foregroundColor(.accentColor)
            .onTapGesture {
                self.favorites.toggleFavorite(self.item)
            }
        )
    }

    func orderNow() {
        order.add(item: item)
    }

}
