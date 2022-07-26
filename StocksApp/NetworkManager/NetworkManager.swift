//
//  NetworkManager.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import Foundation

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    var retrievedToken: String = "cbfqc1aad3ictm4bs4l0"
    
    var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "aidateam.herokuapp.com"
        return components
    }()

    private let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }
    
    func loadMentorProfile(completion: @escaping (News) -> Void) {
        
        var components = urlComponents
        components.path = "/api/user/profile"

        guard let url = components.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(retrievedToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                print("Error: error calling GET")
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("\(String(describing: response))")
                print("Error: HTTP request failed")
                return
            }
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                DispatchQueue.main.async {
                    completion(news)
                }

            } catch {
                print("no json")
            }
        }
        task.resume()
    }
}
