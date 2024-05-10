//
//  RecipeAPIError.swift
//  TanoshiiRecipe
//
//  Created by 井本智博 on 2024/05/06.
//

import Foundation

enum RecipeAPIError: String, Error {
    case invalidURL = "This URL was invalid."

    case invalidResponse = "Invalid response from the server."
    case invalidData = "The data received from the server was invalid. "
    case invalidNetworking = "There was an error when networking. "
}
