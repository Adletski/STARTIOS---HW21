//
//  DetailViewController.swift
//  tb
//
//  Created by Adlet Zhantassov on 25.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var cardImage = createCardImageView()
    private lazy var nameLabel = createLabel()
    private lazy var textLabel = createLabel()
    private lazy var manacostLabel = createLabel()
    private lazy var idLabel = createLabel()
    private lazy var stackView = createVStackView()
    
    var card: Card? {
        didSet {
            NetworkManager.downloadImage(url: card?.imageUrl ?? "") { image in
                self.cardImage.image = image
            }
            self.nameLabel.text = card?.name
            self.idLabel.text = card?.id
            self.manacostLabel.text = card?.manaCost
            self.textLabel.text = card?.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        let views = [cardImage,nameLabel,textLabel,manacostLabel,idLabel]
        view.backgroundColor = .white
        view.addSubview(stackView)
        views.forEach { stackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.equalTo(view.snp.leading).offset(30)
            $0.trailing.equalTo(view.snp.trailing).offset(-30)
            $0.bottom.equalTo(view.snp.bottom).offset(-30)
        }
    }
}
