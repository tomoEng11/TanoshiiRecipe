//
//  Router.swift
//  TanoshiiRecipe
//
//  Created by 井本智博 on 2024/05/06.
//

import UIKit

final class Router {
    static let shared = Router()
    private init(){}
    private var window: UIWindow?

    func showRecipeAlbumVC(window: UIWindow)  {
        let vc = RecipeAlbumVC()
        let presenter = RecipeAlbumPresenter(items: [], output: vc, api: RecipeAPIClient.shared, page: 0, totalItemCount: 0)
        vc.inject(presenter: presenter)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }
}

