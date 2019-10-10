//
//  RatingView.swift
//  iDine
//
//  Created by Michael Long on 10/4/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

class RatingsService: ObservableObject {

    @Published var ratings = [UUID:Int]()

    func rate(_ item: MenuItem, as rating: Int) {
        ratings[item.id] = rating
    }

    func rating(for item: MenuItem) -> Int {
        ratings[item.id] ?? 0
    }

}

struct RatingsSummaryView: View {
    @EnvironmentObject var ratings: RatingsService
    @State var showRatingSheet = false
    let item: MenuItem
    var body: some View {
        let rating = self.ratings.rating(for: self.item)
        return HStack {
            Image(systemName: rating >= 1 ? "star.fill" : "star")
            Image(systemName: rating >= 2 ? "star.fill" : "star")
            Image(systemName: rating >= 3 ? "star.fill" : "star")
            Image(systemName: rating >= 4 ? "star.fill" : "star")
            Image(systemName: rating >= 5 ? "star.fill" : "star")
            }
            .foregroundColor(.red)
            .onTapGesture {
                self.showRatingSheet.toggle()
            }
            .sheet(isPresented: $showRatingSheet) {
                RatingsSheet(presented: self.$showRatingSheet, item: self.item)
                    .modifier(SystemServices())
            }
    }
}

struct RatingsSheet: View {
    @Binding var presented: Bool
    let item: MenuItem
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Button("Close") {
                    self.presented = false
                    }
                    .padding([.leading, .trailing])
                    .padding(.top, 10)
                }

            Image(item.mainImage)
                .resizable()
                .scaledToFit()
                .saturation(1.25)
                .overlay(PhotoCredit(text: item.photoCredit).offset(x: -5, y: -5), alignment: .bottomTrailing)

            VStack(spacing: 20) {

                Text("Rate the \(item.name)!")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 10) {
                    RatingsRow(item: item, value: 5, title: "I love it and will marry it!")
                    RatingsRow(item: item, value: 4, title: "I'll marry it anyway!")
                    RatingsRow(item: item, value: 3, title: "I really, really like it!")
                    RatingsRow(item: item, value: 2, title: "I like it!")
                    RatingsRow(item: item, value: 1, title: "Kill me now...")
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20)

                Text("Obiligatory Disclaimer: If we like your rating we'll use it in all of our advertising. If not, we'll cheerfully ignore it and you'll be dead to us. Please choose wisely.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(. bottom)

                Spacer()
            }
            .padding()

        }
    }
}

struct RatingsRow: View {
    @EnvironmentObject var ratings: RatingsService
    @State var tapped = false
    let item: MenuItem
    let value: Int
    let title: String
    var body: some View {
        let rating = self.ratings.rating(for: self.item)
        return HStack {
            Image(systemName: self.value <= rating ? "star.fill" : "star")
                .foregroundColor(.red)
            Text(title)
            Spacer()
        }
        .opacity(tapped ? 0.3 : 1.0)
        .animation(.default)
        .onTapGesture {
            self.tapped.toggle()
            DispatchQueue.main.delay(0.2) {
                self.tapped.toggle()
                self.ratings.rate(self.item, as: self.value)
            }
        }
    }
}

extension DispatchQueue {
    func delay(_ delay: Double, execute work: @escaping @convention(block) () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: work)
    }
}

struct RatingsSheet_Previews: PreviewProvider {
    static var previews: some View {
        RatingsSheet(presented: .constant(true), item: MenuItem.example)
            .environmentObject(RatingsService())
    }
}
