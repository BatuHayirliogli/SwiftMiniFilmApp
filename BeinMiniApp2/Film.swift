//
//  Film.swift
//  BeinMiniApp2
//
//  Created by Batu Hayırlıoğlu on 12.09.2024.
//
import Foundation

struct Film: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let genreIds: [Int]?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date" // Map to the correct JSON key
        case posterPath = "poster_path" // Map to the correct JSON key
        case genreIds = "genre_ids" // Map to the correct JSON key
    }
}



