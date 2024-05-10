//
//  RecipeAPIClient.swift
//  TanoshiiRecipe
//
//  Created by 井本智博 on 2024/05/06.
//

import Foundation

protocol RecipeAPIProtocol {
    func getRecipeData(page: Int) async throws -> CookingData
}

final class RecipeAPIClient: RecipeAPIProtocol {

    static let shared = RecipeAPIClient()
    private init(){}

    func getRecipeData(page: Int) async throws -> CookingData {
        let endpoint = "https://cooking-records.ex.oishi-kenko.com/cooking_records?"
        let offset = (page) * 10
        let limit = 10
        let parameter = "offset=\(offset)" + "limit=\(limit)"

        guard let url = URL(string: endpoint + parameter) else {
            throw RecipeAPIError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decodedData = try JSONDecoder().decode(CookingData.self, from: data)
        return decodedData
    }
}
