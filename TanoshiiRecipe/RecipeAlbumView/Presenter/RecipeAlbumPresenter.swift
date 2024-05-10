//
//  RecipeAlbumPresenter.swift
//  TanoshiiRecipe
//
//  Created by 井本智博 on 2024/05/06.
//

import Foundation

protocol RecipeAlbumInput {
    func getNewItems()
    func getInitialItems()
    func checkItemsToDisplay(offsetY: CGFloat, contentHeight: CGFloat, height: CGFloat)
}

protocol RecipeAlbumOutput: AnyObject {
    func updateUI(items: [CookingRecord]) async
    func requestNewItems()
}

final class RecipeAlbumPresenter {

    private var items: [CookingRecord]
    private weak var output: RecipeAlbumOutput!
    private var api: RecipeAPIProtocol!
    private var page: Int
    private var totalItemCount: Int

    init(items: [CookingRecord], output: RecipeAlbumOutput!, api: RecipeAPIProtocol, page: Int, totalItemCount: Int) {
        self.output = output
        self.api = api
        self.items = items
        self.page = page
        self.totalItemCount = totalItemCount
    }

    private func nextPagesExist(total: Int) -> Bool {
        let limit = 10
        if  total < ( page + 1) * limit {
            return false
        } else {
            return true
        }
    }
}

extension RecipeAlbumPresenter: RecipeAlbumInput {
    func getNewItems() {
        guard nextPagesExist(total: totalItemCount) == true else { return }
        page += 1
        Task {
            do {
                let newData = try await api.getRecipeData(page: page)
                items.append(contentsOf: newData.cookingRecords)
                await output.updateUI(items: items)
            } catch {
                throw RecipeAPIError.invalidData
            }
        }
    }

    func checkItemsToDisplay(offsetY: CGFloat, contentHeight: CGFloat, height: CGFloat) {
        if offsetY > contentHeight - height {
            output.requestNewItems()
        }
    }

    func getInitialItems() {
        page += 1
        Task {
            do {
                let newData = try await api.getRecipeData(page: page)
                items = newData.cookingRecords
                totalItemCount = newData.pagination.total
                await output.updateUI(items: items)
            } catch {
                throw RecipeAPIError.invalidData
            }
        }
    }
}

