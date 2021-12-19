//
//  MovieDetails.swift
//  MoviesDB
//
//  Created by Ruan Reis on 09/10/20.
//

import Foundation

struct MovieDetails: Decodable {
    
    let id: Int

    let title: String

    let overview: String
    
    let budget: Double
    
    let revenue: Double
    
    let runtime: Int
    
    let genres: [Genre]
    
    let credits: Credits
}
