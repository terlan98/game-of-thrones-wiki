//
//  CharactersErrorView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import SwiftUI

struct CharactersErrorView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image("ned-stark")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 160)
                .opacity(0.85)
            
            Text("Winter has come, and so has an error. Fetching data from beyond the Wall failed. Please check your network connection.")
                .multilineTextAlignment(.center)
                .font(.system(size: 12, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    CharactersErrorView()
}
