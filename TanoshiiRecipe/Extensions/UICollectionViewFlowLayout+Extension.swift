//
//  UICollectionViewFlowLayout+Extension.swift
//  TanoshiiRecipe
//
//  Created by 井本智博 on 2024/05/06.
//

import UIKit

extension UICollectionViewFlowLayout {

    func createOneColumnLayout(view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let itemWidth = width - (padding * 2)

        self.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
        return self
    }
}

