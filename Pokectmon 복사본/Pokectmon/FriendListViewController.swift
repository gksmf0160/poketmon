//
//  FriendListViewController.swift
//  Pokectmon
//
//  Created by 송명균 on 7/9/25.
//

// FriendListViewController.swift

import UIKit
import SnapKit

class FriendListViewController: UIViewController {
    
    private let tableView = UITableView()
    
    // 이제 더미 데이터 대신 진짜 배열!
    private var friends: [(String, String, UIImage?)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        self.title = "친구 목록"
        
        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonTapped))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButtonTapped() {
        let phoneBookVC = PhoneBookViewController()
        // 클로저로 추가 연락처 전달
        phoneBookVC.onSave = { [weak self] name, phone, image in
            self?.friends.append((name, phone, image))
            self?.tableView.reloadData()
        }
        self.navigationController?.pushViewController(phoneBookVC, animated: true)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendCell")
        tableView.dataSource = self
        tableView.rowHeight = 80
    }
}

extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendTableViewCell else {
            return UITableViewCell()
        }
        
        let friend = friends[indexPath.row]
        cell.nameLabel.text = friend.0
        cell.phoneLabel.text = friend.1
        cell.profileImageView.image = friend.2 ?? UIImage(systemName: "person")
        
        return cell
    }
}
