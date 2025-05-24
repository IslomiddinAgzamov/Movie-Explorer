//
//  MovieRow.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    let isFavorite: Bool

    var body: some View {
        HStack {
            AsyncImage(url: movie.posterURL) { image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray
            }
            .frame(width: 80, height: 120)
            .clipped()
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text("Rating: \(movie.rating, specifier: "%.1f")")
                if isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }
            Spacer()
        }
    }
}
