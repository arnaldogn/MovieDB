//
//  Movie.swift
//  Rappi
//
//  Created by Arnaldo on 8/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import RealmSwift

struct MovieList : Codable {
    var id: Int?
    let results:[Movie]
}

struct Movie: Codable {
    var id: Int
    var title: String
    var vote: Float
    var posterPath: String?
    var overview: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case vote = "vote_average"
        case posterPath = "poster_path"
        case overview
    }
}

final public class MovieObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var vote: Float = 0.0
    @objc dynamic var posterPath = ""
    @objc dynamic var overview = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

extension Movie: Persistable {
    public init(managedObject: MovieObject) {
        id = managedObject.id
        title = managedObject.title
        vote = managedObject.vote
        posterPath = managedObject.posterPath
        overview = managedObject.overview
    }
    
    public func managedObject() -> MovieObject {
        let movieObject = MovieObject()
        movieObject.id = id
        movieObject.title = title
        movieObject.vote = vote
        movieObject.posterPath = posterPath ?? ""
        movieObject.overview = overview
        return movieObject
    }
}

final public class MovieListObject: Object {
    @objc dynamic var id = 0
    var results = List<MovieObject>()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

extension MovieList: Persistable {
    public init(managedObject: MovieListObject) {
        id = managedObject.id
        results = managedObject.results.compactMap(Movie.init(managedObject:))
    }
    public func managedObject() -> MovieListObject {
        let movieList = MovieListObject()
        movieList.id = id ?? 0
        results.forEach { movieList.results.append($0.managedObject()) }
        return movieList
    }
}
