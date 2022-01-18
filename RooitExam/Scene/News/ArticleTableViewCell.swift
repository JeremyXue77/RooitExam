//
//  ArticleTableViewCell.swift
//  RooitExam
//
//  Created by Jeremy Xue on 2022/1/18.
//

import UIKit
import Reusable
import SnapKit

class ArticleTableViewCell: UITableViewCell, Reusable {
    
    // MARK: UI
    let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func commonInit() {
        let stackView = UIStackView(arrangedSubviews: [articleImageView, contentLabel])
        stackView.spacing = 16
        stackView.alignment = .center
        contentView.addSubview(stackView)
        articleImageView.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
    }
    
    func configure(with viewModel: ArticleViewModel) {
        self.articleImageView.kf.setImage(with: viewModel.imageURL)
        self.contentLabel.text = viewModel.content
    }
}
