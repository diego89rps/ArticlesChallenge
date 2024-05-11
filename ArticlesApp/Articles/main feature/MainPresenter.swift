//
//  MainPresenter.swift
//  Teste
//
//  Created by Diego Ribeiro on 01/04/24.
//

import Foundation


class MainPresenter {
    
    var model: MainModel?
    
}

extension MainPresenter {
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
