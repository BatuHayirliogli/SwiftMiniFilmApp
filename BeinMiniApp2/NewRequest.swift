import Foundation

class NewRequest {
    
    let url = URL(string: "https://api.themoviedb.org/3/discover/movie")!
    
    func fetchData(withGenre genre: Int) async -> [Film] {  // Change to return an array even on error
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            URLQueryItem(name: "with_genres", value: String(genre))
        ]
        components.queryItems = (components.queryItems ?? []) + queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZGZjZDhiZWRkZTdjYzBlNWVjZGU2NmQ2YzhmMmZiNyIsIm5iZiI6MTcyNjgyMDY5Ny4xODExNzksInN1YiI6IjY2ZTkxOWI0YjY2NzQ2ZGQ3OTBhYTIwYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.cFaxYD9zP3xmM_VfYy0N966O55yHCdW3bCpoLKOuHY8"
        ]
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
    
            let decoder = JSONDecoder()
            let filmResponse = try decoder.decode(FilmResponse.self, from: data)
            return filmResponse.results ?? []  // Return the array of films or an empty array
        } catch {
            // Optionally handle the error, for instance logging it
            return []  // Return an empty array in case of failure
        }
    }
}

