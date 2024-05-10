//
//  RecipeRecordModel.swift
//  TanoshiiRecipe
//
//  Created by 井本智博 on 2024/05/06.
//

import Foundation

struct CookingData: Codable {
    let pagination: Pagination
    let cookingRecords: [CookingRecord]

    enum CodingKeys: String, CodingKey {
        case pagination
        case cookingRecords = "cooking_records"
    }
}

struct Pagination: Codable {
    let total: Int
    let offset: Int
    let limit: Int
}

struct CookingRecord: Codable, Hashable {
    let imageUrl: String
    let comment: String
    let recipeType: String
    let recordedAt: String

    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case comment
        case recipeType = "recipe_type"
        case recordedAt = "recorded_at"
    }
}
