//
//  NetworkingService.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 22/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//

import Foundation
class NetworkingService{
    private init(){}
    static let shared = NetworkingService()
    
    /**
        Stand alone method to make a REST API call
        - Note: Reusable for every call
        - Parameter urlPath:REST API url string
        - Parameter completion:completion handler with genric respose type Result awailable from swift 5 only
    */
    
    func request(_urlPath:String, completion: @escaping(Result<Data, Error>) -> Void){
                guard let url = URL(string: _urlPath) else { return }
                
                URLSession.shared.dataTask(with: url) { (data, resp, err) in
                    
                    if let unwrappedError = err {
                        completion(.failure(unwrappedError))
                        return
                    }
                    else if let unwrappedData = data {
                        completion(.success(unwrappedData))
                    }
                    
                }.resume()
    }
}
