//
//  TMDBService.swift
//  Movie Explorer
//
//  Created by Islomiddin on 24/05/25.
//

import Foundation

class TMDBService {
    private let baseURL = "https://api.themoviedb.org/3/movie/popular"
    private let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NWRkMmE0ZTZiMTc5NDQyMWE1YThjODY1ZDc4OTJlMSIsIm5iZiI6MTc0ODA4MzAzNS41NDQ5OTk4LCJzdWIiOiI2ODMxYTE1YjhmNDdlZDgzNzFiNmFkMjQiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.SvbTVq2eeYpZ6d4TM5nFLy86_SfufvbuPvh1GIHs2eE"

    func fetchPopularMovies(page: Int = 1) async throws -> [Movie] {
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")
        ]

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(TMDBMovieResponse.self, from: data)
        return response.results
    }
}
