//
//  FetchMoviesService.swift
//  Rappi
//
//  Created by Arnaldo on 8/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Alamofire

typealias SearchMoviesCompletionBlock = (_ result: MovieList?, _ error: CustomError?) -> ()

enum SortOption: String {
    case popularity = "popularity.desc"
    case topRated = "vote_average.desc"
    case upcoming = "primary_release_date.desc"
    static let allValues = [popularity, topRated, topRated]
}

enum SortNames: String {
    case popularity = "Popularity"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
}

extension SortNames: CaseIterable {}

protocol SearchMoviesServiceProtocol {
    func fetch(sortedBy option: SortOption, _ completion: @escaping SearchMoviesCompletionBlock)
}

struct SearchMoviesService: SearchMoviesServiceProtocol {
    internal func fetch(sortedBy option: SortOption,_ completion: @escaping SearchMoviesCompletionBlock){
        return DependencyManager.resolve(interface: APIManagerProtocol.self).request(url: Constants.Url.search + option.rawValue, completion: completion)
    }
}
