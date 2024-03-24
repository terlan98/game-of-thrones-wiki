//
//  QuoteView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import SwiftUI
import ComposableArchitecture

struct QuoteView: View {
    let store: StoreOf<QuoteFeature>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            titleAndFetchButton
            
            if store.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if store.fetchFailed {
                QuoteErrorView()
            } else {
                quoteSentence
                quoteAuthor
            }
        }
        .onAppear {
            store.send(.fetchTriggered)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.secondary.opacity(0.1))
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var titleAndFetchButton: some View {
        HStack(alignment: .top) {
            Text("Random Quote")
                .textCase(.uppercase)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary.opacity(0.7))
                .padding(.bottom, 1)
            
            Spacer()
            
            Button(action: {
                store.send(.reset)
                store.send(.fetchTriggered)
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .font(.system(size: 12))
            })
        }
    }
    
    @ViewBuilder
    private var quoteSentence: some View {
        Text("\"\(store.quote?.sentence ?? "-")\"")
            .foregroundStyle(.primary.opacity(0.7))
            .font(.custom("BradleyHandITCTT-Bold", size: 20))
    }
    
    @ViewBuilder
    private var quoteAuthor: some View {
        Text(store.quote?.character.name ?? "")
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundStyle(.secondary)
            .font(.custom("BradleyHandITCTT-Bold", size: 16))
    }
}

#Preview {
    QuoteView(store: Store(initialState: QuoteFeature.State()) {
        QuoteFeature()
    })
}
