//
//  PhoneBookViewController.swift
//  Pokectmon
//
//  Created by 송명균 on 7/9/25.
//

import UIKit
import SnapKit

class PhoneBookViewController: UIViewController {
    
    let profileImageView = UIImageView()
    let randomImageButton = UIButton(type: .system)
    let nameTextField = UITextField()
    let phoneTextField = UITextField()
    
    var onSave: ((_ name: String, _ phone: String, _ image: UIImage?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
    }
    
    private func setupNavigationBar() {
        self.title = "연락처 추가"
        
        let applyButton = UIBarButtonItem(title: "적용", style: .done, target: self, action: #selector(applyButtonTapped))
        self.navigationItem.rightBarButtonItem = applyButton
    }
    
    @objc private func applyButtonTapped() {
        let name = nameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let image = profileImageView.image
        
        // 부모에게 데이터 전달
        onSave?(name, phone, image)
        
        // 뒤로가기
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupViews() {
        view.addSubview(profileImageView)
        view.addSubview(randomImageButton)
        view.addSubview(nameTextField)
        view.addSubview(phoneTextField)
        
        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.gray.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFit
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(120)
        }
        
        randomImageButton.setTitle("랜덤 이미지 생성", for: .normal)
        randomImageButton.addTarget(self, action: #selector(randomImageTapped), for: .touchUpInside)
        
        randomImageButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.placeholder = "이름"
        nameTextField.borderStyle = .roundedRect
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(randomImageButton.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(44)
        }
        
        phoneTextField.placeholder = "전화번호"
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.keyboardType = .phonePad
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.left.right.height.equalTo(nameTextField)
        }
    }
    
    @objc private func randomImageTapped() {
        // ✅ 포켓몬 번호 1~151 까지만
        let randomID = Int.random(in: 1...151)
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(randomID)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  error == nil else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let sprites = json["sprites"] as? [String: Any],
                   let imageURLString = sprites["front_default"] as? String,
                   let imageURL = URL(string: imageURLString) {
                    
                    URLSession.shared.dataTask(with: imageURL) { data, _, error in
                        guard let data = data, error == nil,
                              let image = UIImage(data: data) else { return }
                        
                        DispatchQueue.main.async {
                            self.profileImageView.image = image
                        }
                    }.resume()
                }
            } catch {
                print("JSON 파싱 실패")
            }
        }.resume()
    }
}
