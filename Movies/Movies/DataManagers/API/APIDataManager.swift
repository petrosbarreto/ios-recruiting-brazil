//
//  APIDataManager.swift
//  Movies
//
//  Created by Renan Germano on 12/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class APIDataManager {
    
    // MARK: - Types definition
    private struct RequestURL { ///w300/wdcc8n9BB5gO5Y7zIhHLSzxSTc6.jpg
        private static let apiKey: String = "a843669bd8c7b0e6643bbd5be9dcacb3"
        private static let host: String = "https://api.themoviedb.org/3"
        
        static var readPopular: String { return host + "/movie/popular?api_key=" + apiKey }
        static var readGenres: String { return host + "/genre/movie/list?api_key=" + apiKey }
        static var searchMovies: String { return host + "/search/movie?api_key=" + apiKey }
        
        static func readPopular(fromPage page: Int) -> String { return "\(readPopular)&page=\(page)" }
        static func searchMovies(withTitle title: String) -> String { return "\(searchMovies)&query=\(title.lowercased().replacingOccurrences(of: " ", with: "+"))"}
        
        private static let imageHost: String = "https://image.tmdb.org/t/p"
        private static let posterSize: String = "/w300"
        
        static func readPosterImage(withCode posterCode: String) -> String { return imageHost + posterSize + posterCode }
    }
    
    // MARK: - Functions
    
    static func readPopular(fromPage page: Int, callback: @escaping ([Movie], Error?)->()) {
        if let url = URL(string: RequestURL.readPopular(fromPage: page)) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    callback([], error)
                    return
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let result = try decoder.decode(PopularResult.self, from: data)
                        callback(result.results, nil)
                    } catch {
                        print("Impossible to decode to [Movie] from data.")
                    }
                    
                }
            }
            task.resume()
        } else {
            callback([], nil)
        }
    }
    
    static func searchMovies(withTitle title: String, callback: @escaping ([Movie], Error?)->()) {
        if let url = URL(string: RequestURL.searchMovies(withTitle: title)) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    callback([], error)
                    return
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let result = try decoder.decode(PopularResult.self, from: data)
                        callback(result.results, nil)
                    } catch {
                        print("Impossible to decode to [Movie] from data.")
                    }
                    
                }
            }
            task.resume()
        } else {
            callback([], nil)
        }
    }
    
    static func readGenres(callback: @escaping ([Genre], Error?)->()) {
        if let url = URL(string: RequestURL.readGenres) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    callback([], error)
                    return
                }
                if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let result = try decoder.decode(GenresResult.self, from: data)
                        callback(result.genres, nil)
                    } catch {
                        print("Impossible to decode to [Movie] from data.")
                    }
                    
                }
            }
            task.resume()
        } else {
            callback([], nil)
        }
    }
    
    static func readPosterImage(withCode posterCode: String, callback: @escaping ((UIImage?)->())) {
        if let url = URL(string: RequestURL.readPosterImage(withCode: posterCode)) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let data = data {
                    let image = UIImage(data: data)
                    callback(image)
                }
            }
            task.resume()
        } else {
            
        }
    }
    
}

// MARK: - Helper classes

fileprivate class PopularResult: Decodable {
    var results: [Movie]
}

fileprivate class GenresResult: Decodable {
    var genres: [Genre]
}
