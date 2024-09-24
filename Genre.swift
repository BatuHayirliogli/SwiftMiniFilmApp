//
//  Genre.swift
//  BeinMiniApp
//
//  Created by Batu Hayırlıoğlu on 9.09.2024.
//

import Foundation

struct Genre: Codable, Hashable {
    var id: Int
    var name: String
}

struct GenreResponse: Codable {
    var genres: [Genre]
}







