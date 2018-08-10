//
//  MovieDataModel.swift
//  Rappi
//
//  Created by Arnaldo on 8/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation

class MovieDataModel: NSObject {
    let movie: Movie
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    var title: String {
        return movie.title
    }
    var votes: String {
        return String(format: "%.1f", movie.vote)
    }
    var overview: String {
        return movie.overview
    }
    var posterUrl: URL? {
        guard let path = movie.posterPath else {
            return nil
        }
        return URL(string: Constants.Url.posterBase + path)
    }
}
