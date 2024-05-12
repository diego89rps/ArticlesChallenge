//
//  EndPoint.swift
//  Teste
//
//  Created by Diego Ribeiro on 11/05/24.
//

import Foundation


enum Endpoint {
    case allArticles
    
    private var fullPath: String {
        let baseURL: String = "https://newsapi.org/v2/"
        var endpoint: String
        switch self {
        case .allArticles:
            endpoint = "everything?q=macOS&from=2024-05-10&sortBy=popularity"
        }
    
        let key: String = "&apiKey=b1ac0e5149904c0baa42e3ad7bc3e354"
        return baseURL + endpoint + key
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(self.self) is not valid")
        }
        return url
    }
}


