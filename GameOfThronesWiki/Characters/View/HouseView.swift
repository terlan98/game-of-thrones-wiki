//
//  HouseView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import SwiftUI

struct HouseView: View {
    let house: House?
    
    var body: some View {
        HStack(spacing: 16) {
            Group {
                if let houseIconName = house?.iconName {
                    Image(houseIconName)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                }
            }
            .foregroundStyle(.secondary)
            .frame(maxWidth: 50, maxHeight: 50)
            .clipShape(.rect(cornerRadius: 8))
            
            Text(house?.rawValue ?? "N/A")
                .font(.system(size: 20, weight: .light))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.secondary.opacity(0.1))
        }
        .padding(.horizontal)
    }
}

#Preview {
    HouseView(house: .stark)
}
