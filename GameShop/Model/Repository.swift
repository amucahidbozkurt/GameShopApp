//
//  Repository.swift
//  GameShop
//
//  Created by Ahmet Mücahid BOZKURT on 24.02.2020.
//  Copyright © 2020 Ahmet Mucahid BOZKURT. All rights reserved.
//

import Foundation
struct ProductsData: Codable {
    let name: String
    let developer: String
    let imageUrl: String
    let price: String
    var discountPrice: String?
    let Platforms: [Platforms]
}

struct Platforms: Codable {
    let name: String
    let NumberOfSales: Int
}

final class Repository {
    
    private let apiClient: APIClient!
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getProductsData(_ completion: @escaping ((Result<[ProductsData]>) -> Void)) {
        let resource = Resource(url: URL(string: "https://private-bd6398-appcent.apiary-mock.com/games")!)
        apiClient.load(resource) { (result) in
            switch result {
            case .success(let data):
                do {
                    let items = try JSONDecoder().decode([ProductsData].self, from: data)
                    completion(.success(items))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
