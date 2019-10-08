//
//  DetailView.swift
//  iDine
//
//  Created by Michael Long on 9/19/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    @EnvironmentObject var order: Order
    @State var rating: Int = 0
    @State var showRatingSheet = false

    let item: MenuItem

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                    .saturation(1.25)
                    .overlay(PhotoCredit(text: item.photoCredit).offset(x: -5, y: -5), alignment: .bottomTrailing)

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
                    RatingsSummaryView(item: item)
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
        }
        .navigationBarTitle("Details", displayMode: .inline)
        .navigationBarItems(trailing: FavoritesButton(item: item))
    }

    func orderNow() {
        order.add(item: item)
    }

}

fileprivate struct FavoritesButton: View {
    @EnvironmentObject var favorites: FavoritesService
    let item: MenuItem
    var body: some View {
        Button(action: { self.favorites.toggleFavorite(self.item) }) {
            Image(systemName: favorites.isFavorite(item) ? "heart.fill" : "heart")
                .foregroundColor(.accentColor)
        }
        .frame(width: 25, height: 25) // improve hit target
    }
}

struct PhotoCredit: View {
    let text: String
    var body: some View {
        Text("Photo © \(text)")
            .padding(4)
            .font(.caption)
            .background(Color.black)
            .foregroundColor(.white)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: MenuItem.example)
            .environmentObject(FavoritesService())
            .environmentObject(Order())
            .environmentObject(RatingsService())
    }
}
