//
//  OverView.swift
//  iDine
//
//  Created by Michael Long on 9/19/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

struct OrderView: View {

    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView {
            List {
                if order.items.isEmpty {
                    Text("You've yet to order anything today...")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(order.items) { item in
                        HStack {
                            Image(item.thumbnailImage)
                                .clipShape(Circle())
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price).00")
                        }
                    }
                    .onDelete(perform: deleteItems)

                    HStack {
                         Text("Total")
                         Spacer()
                         Text("$\(order.total).00")
                        }
                        .foregroundColor(.gray)
                }
                if !order.items.isEmpty {
                    NavigationLink(destination: CheckoutView()) {
                        Text("Checkout")
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .padding()
            .navigationBarTitle(Text("iDine Order"))
            .navigationBarItems(trailing: EditButton())

        }
    }

    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        let order = Order()
        order.add(item: MenuItem.example)
        return OrderView()
            .environmentObject(order)
    }
}
