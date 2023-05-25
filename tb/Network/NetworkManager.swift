//
//  NetworkManager.swift
//  tb
//
//  Created by Adlet Zhantassov on 24.05.2023.
//

import Foundation
import Alamofire
import CryptoKit
import UIKit

struct Constants {
    static let timestamp = "1"
    static let apikey = "1997c7c4f7faca27895511a0a612165e"
    static let privatekey = "479d33127222d1dc9d57c8f72b4d4841fa7bb550"
    static let url = "https://api.magicthegathering.io/v1/cards"
    static var hash: String {
        MD5(string: timestamp+privatekey+apikey)
    }
}

func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: Data(string.utf8))

    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

struct NetworkManager {
    
    static func makeRequest(completion: @escaping ([Card]) -> Void) {
        let request = AF.request(Constants.url)
        request.responseDecodable(of: Cards.self) { data in
            if data.response?.statusCode == 200 {
                guard let char = data.value else { return }
                let cards = char.cards
                completion(cards)
            } else {
                print("error")
            }
        }
    }
    
    static func downloadImage(url: String, completion: @escaping ((UIImage) -> Void)) {
        AF.request(url).responseData { data in
            if data.response?.statusCode == 200 {
                guard let data = data.value else { return }
                guard let image = UIImage(data: data) else { return }
                completion(image)
                return
            } else {
                print("error")
            }
        }
    }
}
