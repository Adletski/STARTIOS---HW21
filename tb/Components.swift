//
//  Components.swift
//  tb
//
//  Created by Adlet Zhantassov on 25.05.2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func createLabel(_ textColor: UIColor = .black, _ font: UIFont = .systemFont(ofSize: 15)) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.numberOfLines = 0
        label.font = font
        return label
    }
    
    func createButton() -> UIButton {
        let button = UIButton()
        
        return button
    }
    
    func createCardImageView() -> UIImageView {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }
    
    func createHStackView(_ spacing: CGFloat = 10) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = spacing
        return stackView
    }
    
    func createVStackView(_ spacing: CGFloat = 10) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.distribution = .fillProportionally
        return stackView
    }
}
