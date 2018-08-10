//
//  APIManager.swift
//  Rappi
//
//  Created by Arnaldo on 8/9/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Alamofire

protocol APIManagerProtocol {
    func request<T: Decodable>(url: String, completion: @escaping (_ result: T?, _ error: CustomError?) -> ())
}

struct APIManager: APIManagerProtocol {
    internal func request<T: Decodable>(url: String, completion: @escaping (_ result: T?, _ error: CustomError?) -> ()) {
        let headers = [String: String]()
        Alamofire.request(url, method: .get, headers: headers).responseJSON() { response in
            guard let jsonData = response.data else { return completion(nil, CustomError(response.result.error)) }
            let decoder = JSONDecoder()
            guard let item = try? decoder.decode(T.self, from: jsonData) else { return completion(nil, try? decoder.decode(CustomError.self, from: jsonData))}
            return completion(item, nil)
        }
    }
}
