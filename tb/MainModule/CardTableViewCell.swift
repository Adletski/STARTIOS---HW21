//
//  CardTableViewCell.swift
//  tb
//
//  Created by Adlet Zhantassov on 24.05.2023.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    static let identifier = "CardTableViewCell"
    
    func configure(card: Card) {
        self.nameLabel.text = card.name
        self.idLabel.text = card.id
        guard let cardImageUrl = card.imageUrl else { return }
        NetworkManager.downloadImage(url: cardImageUrl) { image in
            self.cardImageView.image = image
            print("adlet")
        }
    }
    
    private lazy var cardImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(cardImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(chevronImageView)
    }
    
    private func setupConstraints() {
        cardImageView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(5)
            $0.leading.equalTo(contentView).offset(5)
            $0.bottom.equalTo(contentView).offset(-5)
            $0.width.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.leading.equalTo(cardImageView.snp.trailing).offset(10)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.equalTo(cardImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-40)
        }
        
        chevronImageView.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
        }
    }

}
