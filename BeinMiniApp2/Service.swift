import Foundation

class Service {
    
    var genreIds: [Int] = []
    var genreNames: [String] = []
    var genres: [Genre] = []
    var filmsByGenre: [[Film]] = []

    let newRequest = NewRequest() // Create an instance of NewRequest

    // Method to fetch genres and films
    func fetchData(completion: @escaping ([String], [[Film]]) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        // Fetch genres
        dispatchGroup.enter()
        fetchGenres { [weak self] genreIds, genreNames in
            guard let self = self else { return }
            self.genreIds = genreIds
            self.genreNames = genreNames
            self.genres = zip(genreIds, genreNames).map { Genre(id: $0.0, name: $0.1) }
            dispatchGroup.leave()
        }

        // Notify when genres are fetched
        dispatchGroup.notify(queue: .main) {
            // Now that we have genreIds, fetch films for each genre
            self.filmsByGenre = Array(repeating: [], count: self.genreIds.count)  // Initialize films by genre
            
            for (index, genreId) in self.genreIds.enumerated() {
                dispatchGroup.enter()
                Task {
                    let films = await self.newRequest.fetchData(withGenre: genreId)
                    self.filmsByGenre[index] = films  // Store films at the correct index
                    dispatchGroup.leave()
                }
            }

            // Notify when all film fetches are done
            dispatchGroup.notify(queue: .main) {
                self.populateGenreArrays { genreNames, films in
                    completion(genreNames, films) // Pass genre names and films arrays
                }
            }
        }
    }

    // Populates two arrays: one for genres (already set) and one for films by genre
    func populateGenreArrays(completion: @escaping ([String], [[Film]]) -> Void) {
        completion(genreNames, filmsByGenre)
    }

    // Fetch genres from the API
    func fetchGenres(completion: @escaping (_ genreIds: [Int], _ genreNames: [String]) -> Void) {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=3bb3e67969473d0cb4a48a0dd61af747&language=en-US"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch data: \(error?.localizedDescription ?? "No error info")")
                return
            }
            
            do {
                let genreResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
                let genres = genreResponse.genres

                let genreIds = genres.map { $0.id }
                let genreNames = genres.map { $0.name }
                
                completion(genreIds, genreNames)
                
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}


