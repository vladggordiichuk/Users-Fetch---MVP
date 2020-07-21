//
//  NetworkManager.swift
//  Table List
//
//  Created by Vlad Gordiichuk on 21.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private init() { }
    
    static func performRequest<D: Encodable, R: Decodable>(to endpoint: Endpoint, with jsonData: D, completion: @escaping (Result<R>) -> Void) {
        
        let urlComponents = NSURLComponents(url: endpointToUrl(endpoint), resolvingAgainstBaseURL: false)
        var httpBody: Data?
        
        do {
            let data = try JSONEncoder().encode(jsonData)
            if endpoint.method == .get {
                if let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    var queryItems = [URLQueryItem]()
                    for (key, value) in dict {
                        queryItems.append(URLQueryItem(name: key, value: "\(value)"))
                    }
                    urlComponents?.queryItems = queryItems
                }
            } else {
                httpBody = data
            }
        } catch {
            return completion(.failure(.jsonConversionFailure))
        }
        
        guard let url = urlComponents?.url else { return completion(.failure(.jsonConversionFailure)) }
        
        var request = URLRequest(url: url.absoluteURL)
        request.httpBody = httpBody
        request.httpMethod = endpoint.method.rawValue
        request.timeoutInterval = 10
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error, error._code == -999 {
                return completion(.failure(.requestCanceled))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.requestFailed))
            }

            if response.statusCode != 200 {
                return completion(.failure(.responseUnsuccessful))
            }
                        
            guard let data = data else {
                return completion(.failure(.invalidData))
            }
            
            do {
                let data = try JSONDecoder().decode(R.self, from: data)
                return completion(.success(data))
            } catch {
                print(error)
                return completion(.failure(.jsonParsingFailure))
            }
        }.resume()
    }
    
    static private func endpointToUrl(_ endpoint: Endpoint) -> URL {
        
        let urlString = "https://reqres.in/api/" + endpoint.pathEnding
        let url = URL(string: urlString)!
        
        return url
    }
    
}
