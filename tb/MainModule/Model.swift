//
//  Model.swift
//  tb
//
//  Created by Adlet Zhantassov on 24.05.2023.
//

import Foundation

struct Cards: Codable {
    let cards: [Card]
}

// MARK: - Card
struct Card: Codable {
    let name: String
    let manaCost: String
    let text: String
    let imageUrl: String?
    let id: String
}
