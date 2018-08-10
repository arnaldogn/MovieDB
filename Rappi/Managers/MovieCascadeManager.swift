//
//  MovieCascadeManager.swift
//  Rappi
//
//  Created by Arnaldo on 8/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit
import MBProgressHUD
import EasyRealm
import RealmSwift

protocol MovieCascadeDelegate: class {
    func didSelect(_ movie: MovieDataModel)
}

protocol MovieCascadeManagerProtocol {
    var view: MovieCascadeView { get }
    var selector: UISegmentedControl { get }
    var searchBar: UISearchBar { get }
    func loadMovies(sortedBy option: SortOption)
    var delegate: MovieCascadeDelegate? { get set }
}

class MovieCascadeManager: NSObject, MovieCascadeManagerProtocol {
    var movieList = [Movie]()
    private var recentList = [Movie]()
    private let service: SearchMoviesServiceProtocol
    internal let view = MovieCascadeView(frame: .zero)
    weak var delegate: MovieCascadeDelegate?
    private let realm = try! Realm()
    internal lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        return searchBar
    }()
    internal lazy var selector: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.tintColor = .white
        SortNames.allCases.forEach {
            segmentedControl.insertSegment(withTitle: $0.rawValue, at: $0.hashValue, animated: false)
        }
        segmentedControl.selectedSegmentIndex = SortNames.popularity.hashValue
        segmentedControl.addTarget(self, action: #selector(optionSelected(sender:)), for: .valueChanged)
        return segmentedControl
    }()
    
    init(service: SearchMoviesServiceProtocol) {
        self.service = service
        super.init()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.defaultIdentifier)
    }
    
    internal func loadMovies(sortedBy option: SortOption) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        service.fetch(sortedBy: option) { (response, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.movieList.removeAll()
            guard error == nil, let movies = response?.results else {
                guard let cached = self.loadCachedMovies(option.hashValue) else { return }
                self.movieList = MovieList(managedObject: cached).results
                self.view.collectionView.reloadData()
                return
            }
            self.movieList = movies
            self.saveMovieList(movies)
            self.view.collectionView.reloadData()
        }
    }
    
    @objc private func optionSelected(sender: UISegmentedControl) {
        loadMovies(sortedBy: SortOption.allValues[sender.selectedSegmentIndex])
    }
    
    private func loadCachedMovies(_ listId: Int) -> MovieListObject? {
        return try? MovieListObject.er.fromRealm(with: listId)
    }
    
    private func saveMovieList(_ movies: [Movie]) {
        try? MovieList(id: selector.selectedSegmentIndex, results: movies).managedObject().er.save(update: true)
    }
}

extension MovieCascadeManagerProtocol {
    func loadMovies() {
        return loadMovies(sortedBy: .popularity)
    }
}

extension MovieCascadeManager: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadMovies(sortedBy: SortOption.allValues[selector.selectedSegmentIndex])
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        movieList = movieList.filter { $0.title.range(of: text) != nil }
        view.collectionView.reloadData()
    }
}

extension MovieCascadeManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.defaultIdentifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: MovieDataModel(movieList[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(MovieDataModel(movieList[indexPath.row]))
    }
}
