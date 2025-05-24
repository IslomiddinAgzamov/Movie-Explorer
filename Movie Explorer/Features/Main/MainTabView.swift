//
//  MainTabView.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Label("Movies", systemImage: "film")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "bookmark")
                }
        }
    }
}
