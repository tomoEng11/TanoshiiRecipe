//
//  RecipeAlbumVC.swift
//  TanoshiiRecipe
//
//  Created by 井本智博 on 2024/05/06.
//

import UIKit

final class RecipeAlbumVC: UIViewController {

    private enum Section: Hashable{
        case main
    }

    private var collectionView: UICollectionView!
    private var datasource: UICollectionViewDiffableDataSource<Section, CookingRecord>!
    private var presenter: RecipeAlbumInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHiararchy()
        configureDataSource()
        presenter.getInitialItems()
    }

    func inject(presenter: RecipeAlbumInput) {
        self.presenter = presenter
    }
}

private extension RecipeAlbumVC {
    func configureHiararchy() {
        let flowLayout = UICollectionViewFlowLayout().createOneColumnLayout(view: self.view)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        collectionView.register(RecipeAlbumViewCell.self, forCellWithReuseIdentifier: RecipeAlbumViewCell.reuseID)
        collectionView.delegate = self
    }
}

private extension RecipeAlbumVC {
    func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource<Section, CookingRecord>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeAlbumViewCell.reuseID, for: indexPath) as! RecipeAlbumViewCell
            cell.set(with: item)
            cell.backgroundColor = .systemTeal
            return cell
        })
    }
}

extension RecipeAlbumVC: UICollectionViewDelegate {

    //scrollが一番下まで来た時に新規データの取得
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        presenter.checkItemsToDisplay(offsetY: offsetY, contentHeight: contentHeight, height: height)
    }
}

extension RecipeAlbumVC: RecipeAlbumOutput {
    func requestNewItems() {
        presenter.getNewItems()
    }

    func updateUI(items: [CookingRecord]) async {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CookingRecord>()
          snapshot.appendSections([.main])
          snapshot.appendItems(items)
        await datasource.apply(snapshot, animatingDifferences: false)
    }
}


