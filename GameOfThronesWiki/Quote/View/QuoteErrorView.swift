//
//  QuoteErrorView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import SwiftUI

struct QuoteErrorView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: "xmark")
                .font(.system(size: 30, weight: .semibold))
                .foregroundStyle(.red.opacity(0.6))
            
            Text("The Three-Eyed Raven must be napping. Unable to fetch the quote :(")
                .multilineTextAlignment(.center)
                .font(.system(size: 12, weight: .semibold))
                .textCase(.uppercase)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    QuoteErrorView()
}
