//
//  ViewController.swift
//  tb
//
//  Created by Adlet Zhantassov on 24.05.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var mainViewModel = MainViewModel()
    
    lazy var tb: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.identifier)
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tb)
        tb.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        NetworkManager.makeRequest { cards in
            self.mainViewModel.cards = cards
            self.tb.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier, for: indexPath) as? CardTableViewCell else { return UITableViewCell() }
        cell.configure(card: mainViewModel.cards[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.card = mainViewModel.cards[indexPath.row]
        present(detailVC, animated: true)
    }
}
