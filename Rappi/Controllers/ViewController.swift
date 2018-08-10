//
//  ViewController.swift
//  Rappi
//
//  Created by Arnaldo on 8/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var manager = DependencyManager.resolve(interface: MovieCascadeManagerProtocol.self)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        manager?.loadMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupViews() {
        title = "MovieDB".localized
        edgesForExtendedLayout = []
        view.backgroundColor = .black
        guard var manager = manager else { return }
        manager.delegate = self
        view.addSubviewsForAutolayout(manager.view, manager.selector, manager.searchBar)
        setupConstraints()
    }
    
    func setupConstraints() {
        guard let manager = manager else { return }
        let views = ["cascade": manager.view,
                     "selector": manager.selector,
                     "searchBar": manager.searchBar]
        view.addConstraints(
            NSLayoutConstraint.constraints("H:|[searchBar]|", views: views),
            NSLayoutConstraint.constraints("H:|-40-[selector]-40-|", views: views),
            NSLayoutConstraint.constraints("H:|[cascade]|", views: views),
            NSLayoutConstraint.constraints("V:|[searchBar]-20-[selector]-20-[cascade]|", views: views))
    }
}

extension ViewController: MovieCascadeDelegate {
    func didSelect(_ movie: MovieDataModel) {
        navigationController?.pushViewController(MovieDetailViewController(movie: movie), animated: true)
    }
}

