//
//  DataProvider.swift
//  Teste
//
//  Created by Diego Ribeiro on 11/05/24.
//

import Foundation

protocol DataProviderProtocol {
    func fetchAllArticles() async throws -> ArticlesModel
    func fetchImageData(imageURLString: String) async throws -> Data
}

class DataProvider: DataProviderProtocol {
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
    
    func fetchImageData(imageURLString: String) async throws -> Data {
        guard let url = URL(string: imageURLString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
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
