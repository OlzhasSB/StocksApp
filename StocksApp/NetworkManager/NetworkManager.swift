//
//  NetworkManager.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

protocol Networkable {
    func loadStocks(path: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func loadNews(path: String, completion: @escaping (Result<[News], NetworkError>) -> Void)
}

final class NetworkManager: Networkable {

    private let API_KEY = "cbcgmuiad3ib4g5ulqdg"
    static var shared = NetworkManager()
    
    private lazy var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "finnhub.io"
        components.queryItems = [
            URLQueryItem(name: "token", value: API_KEY)
        ]
        return components
    }()

    private let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }
    
    func loadStocks(path: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        
        var components = urlComponents
        components.path = path
        
        guard let url = components.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                let stocksList = try JSONDecoder().decode([Stock].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(stocksList))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }
        task.resume()
    }
    
    func loadNews(path: String, completion: @escaping (Result<[News], NetworkError>) -> Void) {
        
        var components = urlComponents
        components.path = path
        
        guard let url = components.url else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                let news = try JSONDecoder().decode([News].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(news))
                }

            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }
        task.resume()
    }
}
