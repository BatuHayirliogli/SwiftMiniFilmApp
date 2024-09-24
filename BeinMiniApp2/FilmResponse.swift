//
//  FilmResponse.swift
//  BeinMiniApp2
//
//  Created by Batu Hayırlıoğlu on 13.09.2024.
//

import Foundation

struct FilmResponse: Codable {
    let page: Int?
    let results: [Film]?
    let totalPages: Int? // Made optional to handle missing values
    let totalResults: Int? // Made optional to handle missing values
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages" // Maps to the correct key if it exists
        case totalResults = "total_results" // Maps to the correct key if it exists
    }
}

