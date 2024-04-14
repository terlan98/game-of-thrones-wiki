//
//  FavoritesEmptyView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 30.03.24.
//

import SwiftUI

struct FavoritesEmptyView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("hound")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 140)
                .opacity(0.85)
            
            Text("Winterfell's Crypts are Empty.\nAdd Your Beloved Characters to Honor Their Memory")
                .multilineTextAlignment(.center)
                .font(.system(size: 12, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    FavoritesEmptyView()
}
