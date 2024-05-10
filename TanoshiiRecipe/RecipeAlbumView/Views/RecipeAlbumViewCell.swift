//
//  RecipeAlbumViewCell.swift
//  TanoshiiRecipe
//
//  Created by 井本智博 on 2024/05/06.
//

import UIKit
import Kingfisher

final class RecipeAlbumViewCell: UICollectionViewCell {

    static let reuseID = "RecipeRecordViewCell"
    private let recipeImageView = UIImageView()
    private let commentLabel = UILabel()
    private let recipeTypeLabel = UILabel()
    private let recordedAtLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
//comment->recipeTypeとrecordAt->imageの順で呼ぶ。(制約に依存関係があるから)
        configureCommentLabel()
        configureRecordedAtLabel()
        configureRecipeTypeLabel()
        configureRecipeImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(with item: CookingRecord) {
        self.commentLabel.text = item.comment
        self.recipeTypeLabel.text = item.recipeType
        self.recordedAtLabel.text = item.recordedAt
        self.recipeImageView.kf.setImage(with: URL(string: item.imageUrl))
    }

    private func configureCommentLabel() {
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.numberOfLines = 4
        contentView.addSubview(commentLabel)
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            commentLabel.heightAnchor.constraint(equalToConstant: 50),
            commentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            commentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -8)
        ])
    }

    private func configureRecipeTypeLabel() {
        recipeTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recipeTypeLabel)
        NSLayoutConstraint.activate([
            recipeTypeLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8),
            recipeTypeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            recipeTypeLabel.heightAnchor.constraint(equalToConstant: 20),
            recipeTypeLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func configureRecordedAtLabel() {
        recordedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recordedAtLabel)
        recordedAtLabel.textAlignment = .right
        NSLayoutConstraint.activate([
            recordedAtLabel.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 8),
            recordedAtLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            recordedAtLabel.widthAnchor.constraint(equalToConstant: 200),
            recordedAtLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func configureRecipeImageView() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.backgroundColor = .systemYellow
        contentView.addSubview(recipeImageView)
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: recipeTypeLabel.bottomAnchor, constant: 8),
            recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}
