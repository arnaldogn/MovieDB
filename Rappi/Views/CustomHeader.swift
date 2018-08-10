//
//  CustomHeader.swift
//  Rappi
//
//  Created by Arnaldo on 8/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

class CustomHeader: UICollectionReusableView {
    var title: String? {
        didSet {
            label.text = title
        }
    }
    private lazy var label: UILabel = {
        let label = UILabel(frame: frame)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupViews()
    }
    private func setupViews() {
        frame = CGRect(x: 0, y: 0, width: bounds.width, height: 50)
        addSubview(label)
    }
}
