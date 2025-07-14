//
//  FriendTableViewCell.swift
//  Pokectmon
//
//  Created by 송명균 on 7/9/25.
//

import UIKit
import SnapKit

class FriendTableViewCell: UITableViewCell {
    
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let phoneLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneLabel)
        
        profileImageView.layer.cornerRadius = 30
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(profileImageView.snp.right).offset(16)
        }
        
        phoneLabel.font = .systemFont(ofSize: 14)
        phoneLabel.textColor = .darkGray
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(nameLabel)
        }
    }
}
