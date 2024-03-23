//
//  ContentView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 22.03.24.
//

import SwiftUI

// https://gameofthronesquotes.xyz
// http://thronesapi.com

struct ContentView: View {
    var body: some View {
        TabView {
            Text("TAB 1")
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
            
            Text("TAB 2")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
        }
    }
}

#Preview {
    ContentView()
}
