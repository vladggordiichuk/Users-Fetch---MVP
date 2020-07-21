//
//  DetailsViewController.swift
//  Table List
//
//  Created by Vlad Gordiichuk on 21.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit
import SafariServices

class DetailsView: UIViewController {
    
    private var user: User
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(with user: User) {
        self.user = user
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(generateDetailStackView(with: "ID", and: String(user.id)))
        
        stackView.addArrangedSubview(generateDetailStackView(with: "Full Name", and: user.firstName + " " + user.lastName))
        
        stackView.addArrangedSubview(generateDetailStackView(with: "Email", and: user.email))
        
        stackView.addArrangedSubview(generateDetailStackView(with: "Avatar", and: user.avatar?.absoluteString ?? "User Has No Avatar"))
        
        if user.avatar != nil {
            
            let button = UIButton(type: .system)
            button.setTitle("Show User Avatar", for: [])
            button.addTarget(self, action: #selector(openURL), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            stackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15),
        ])
    }
    
    private func generateDetailStackView(with title: String, and value: String) -> UIStackView {
        
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(generateTitleLabel(title))
        stackView.addArrangedSubview(generateValueLabel(value))
        
        return stackView
    }
    
    private func generateTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func generateValueLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    @objc private func openURL() {
        
        guard let avatarURL = user.avatar else { return }
        
        let safariViewController = SFSafariViewController(url: avatarURL)
        present(safariViewController, animated: true, completion: nil)
    }
}
