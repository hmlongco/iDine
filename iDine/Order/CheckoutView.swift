//
//  CheckoutView.swift
//  iDine
//
//  Created by Michael Long on 9/20/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

class CheckoutViewModel {

    static let paymentTypes = ["Cash", "Apple Pay", "Credit Card"]
    static let tipAmounts = [10, 15, 20, 0]

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var order: Order

    @State var paymentType = 0
    @State var tipIndex = 1
    @State var showLoyaltyCard = false
    @State var loyaltyCardNumber = ""

    var orderTotal: Double {
        let total = Double(order.total)
        let tip = Double(Self.tipAmounts[tipIndex])
        return total + (total * (tip / 100.0))
    }

}

struct CheckoutView: View {

    static let paymentTypes = ["Cash", "Apple Pay", "Credit Card"]
    static let tipAmounts = [10, 15, 20, 0]

    @EnvironmentObject var appState: AppState
    @EnvironmentObject var messages: MessageService
    @EnvironmentObject var order: Order

    @State var paymentType = 0
    @State var tipIndex = 1
    @State var showLoyaltyCard = false
    @State var loyaltyCardNumber = ""
    @State var orderPlaced = false

    var formattedOrderTotal: String {
        let tip = Double(Self.tipAmounts[tipIndex])
        return order.formattedTotalWithTip(tip)
    }

    var body: some View {
        Form {
            Section {
                Picker("Payment Type", selection: $paymentType) {
                    ForEach(0 ..< Self.paymentTypes.count) { index in
                        Text(Self.paymentTypes[index])
                    }
                }
                Toggle(isOn: $showLoyaltyCard.animation()) {
                    Text("iDine Member")
                }
                if showLoyaltyCard {
                    TextField("Enter Membership Number", text: $loyaltyCardNumber)
                }
            }

            Section {
                Picker("Tip", selection: $tipIndex) {
                    ForEach(0 ..< Self.tipAmounts.count) { index in
                        Text("\(Self.tipAmounts[index])%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section {
                HStack {
                    Text("Order Total")
                    Spacer()
                    Text(formattedOrderTotal)
                    }
                Button(action: checkout) {
                    Text("Place Order")
                }
            }
        }
        .disabled(orderPlaced)
        .navigationBarTitle(Text("Order Checkout"), displayMode: .inline)
    }

    func checkout() {
        orderPlaced = true
        appState.currentTab = .favorites
        messages.show(message: "Your order in the amount of \(formattedOrderTotal) has been placed.")
        order.items = []
    }

}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        let order = Order()
        order.add(item: MenuItem.example)
        return CheckoutView()
            .environmentObject(order)
            .environmentObject(AppState())
            .accentColor(.red)
    }
}

