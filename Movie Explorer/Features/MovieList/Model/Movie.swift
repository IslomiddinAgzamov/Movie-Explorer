//
//  Movie.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import Foundation

struct Movie: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let poster_path: String?
    let vote_average: Double
    let overview: String
    let release_date: String

    var posterURL: URL? {
        guard let path = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    var rating: Double { vote_average }
    var releaseDate: String { release_date }
}
