//
//  MainMenuRow.swift
//  iDine
//
//  Created by Michael Long on 9/19/19.
//  Copyright © 2019 Michael Long. All rights reserved.
//

import SwiftUI

struct MainMenuRow: View {
    let item: MenuItem
    var body: some View {
        NavigationLink(destination: DetailView(item: item)) {
            HStack {
                Image(item.thumbnailImage)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("$\(item.price).00")
                        .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                Spacer()
                ItemRestrictionView(restrictions: item.restrictions)
            }
        }
    }
}

struct ItemRestrictionView: View {
    static let colors: [String:Color] = ["G":Color(red: 0.7, green: 0.3, blue: 0.3), "S":.red, "D":.blue, "V":.green, "N":.yellow]
    let restrictions: [String]
    var body: some View {
        HStack(spacing: 4) {
            ForEach(restrictions, id: \String.self) { restriction in
                Text(restriction)
                    .padding(4)
                    .background(Self.colors[restriction] ?? .gray)
                    .font(.subheadline)
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
        }
    }
}

#if DEBUG
struct MainMenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuRow(item: MenuItem.example)
    }
}
#endif
