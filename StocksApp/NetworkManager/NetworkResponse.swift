//
//  NetworkResponse.swift
//  StocksApp
//
//  Created by Aida Moldaly on 26.07.2022.
//

import Foundation

enum APINetworkError: Error {
    case dataNotFound
    case httpRequestFailed
    case dontHaveRights(String)
}

extension APINetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return "Error: Did not receive data"
        case .httpRequestFailed:
            return "Error: HTTP request failed"
        case .dontHaveRights:
            return "Error: You don't have rights"
        }
    }
}
