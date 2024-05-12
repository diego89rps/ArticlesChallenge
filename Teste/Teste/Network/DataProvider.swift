//
//  DataProvider.swift
//  Teste
//
//  Created by Diego Ribeiro on 11/05/24.
//

import Foundation

class DataProvider {
    func fetchAllArticles() async throws -> ArticlesModel {
        do {
            let (data, _) = try await URLSession.shared.data(from: Endpoint.allArticles.url)
            printResponse(data: data)

            let decodeData = try JSONDecoder().decode(ArticlesModel.self, from: data)
            return decodeData
        } catch {
            throw error
        }
    }
    
}

extension DataProvider {
    func printResponse(data: Data) {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("Não foi possível converter os dados em um objeto JSON.")
                return
            }
            print("############# START RESPONSE ")
            print(json)
            print("############# ENDING RESPONSE ")
        } catch {
            print("Erro ao converter os dados em JSON:", error)
        }
    }
}