//
//  CustomError.swift
//  Rappi
//
//  Created by Arnaldo on 8/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation

struct CustomError: Codable {
    var errors: [String]?
    var message: String? { get { return errors?.first } }
    
    init(_ error: Error? = nil) {
        guard let error = error?.localizedDescription
            else {
                self.errors = ["Ups something went wrong".localized]
                return
        }
        self.errors = [error]
    }
}
