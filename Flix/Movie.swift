//
//  Movie.swift
//  Flix
//
//  Created by Simona Virga on 2/8/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import Foundation

class Movie
{
    var title: String
    var posterURL: URL?
    var posterPath: String
    var overview: String
    var releaseDate: String
    var backdropPath: String
    var backdropURL: URL?
    
    init(dictionary: [String: Any])
    {
        title = dictionary["title"] as? String ?? "No title"
        
        posterPath = dictionary["poster_path"] as? String ?? "No path"
        posterURL = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
        
        overview = dictionary["overview"] as? String ?? "No description"
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
   
        backdropPath = dictionary["backdrop_path"] as? String ?? "No path"
        backdropURL = URL(string: "https://image.tmdb.org/t/p/w500" + backdropPath)
        
    }
    
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie]
    {
        var movies: [Movie] = []
        for dictionary in dictionaries
        {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
