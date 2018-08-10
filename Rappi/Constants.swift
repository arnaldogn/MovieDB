//
//  Constants.swift
//  Rappi
//
//  Created by Arnaldo on 8/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation

enum Constants {
    enum Url {
        static let base = "https://api.themoviedb.org/3/discover/movie?api_key=a5975864ebeb181f9c44e2c959134f1b&language=en-US&include_adult=false&include_video=false&page=1"
        static let search = base + "&sort_by="
        static let posterBase = "https://image.tmdb.org/t/p/w500"
    }
    
}
