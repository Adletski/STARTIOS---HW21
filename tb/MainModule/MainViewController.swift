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
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Place name of character..."
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(textField)
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(textField.snp.trailing).offset(5)
            $0.trailing.equalTo(view.snp.trailing).offset(-5)
            $0.height.equalTo(40)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.snp.leading).offset(10)
            $0.trailing.equalTo(view.snp.trailing).offset(-70)
            $0.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        NetworkManager.makeRequest { cards in
            self.mainViewModel.cards = cards
            self.tableView.reloadData()
        }
    }
    
    @objc
    func buttonPressed() {
        
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text {
            filterText(text+string)
        }
        
        return true
    }
    
    func filterText(_ query: String) {
        mainViewModel.filteredData.removeAll()
        for card in mainViewModel.cards {
            if card.name.lowercased().starts(with: query.lowercased()) {
                mainViewModel.filteredData.append(card)
            }
        }
        tableView.reloadData()
        mainViewModel.isFiltered = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !mainViewModel.filteredData.isEmpty {
            return mainViewModel.filteredData.count
        }
        return mainViewModel.isFiltered ? 0 : mainViewModel.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.identifier, for: indexPath) as? CardTableViewCell else { return UITableViewCell() }
        if !mainViewModel.filteredData.isEmpty {
            cell.configure(card: mainViewModel.filteredData[indexPath.row])
        } else {
            cell.configure(card: mainViewModel.cards[indexPath.row])
        }
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
