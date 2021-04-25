//
//  UserInvertedCell.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import UIKit

class UserInvertedCell: UITableViewCell {
    
    // MARK: Internal Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let textContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 8
        return stack
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
}

// MARK: UIView Lifecycle
extension UserInvertedCell {
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userAvatar.layer.cornerRadius = userAvatar.frame.width / 2
    }
    
}

// MARK: Setup
extension UserInvertedCell {
    
    private func setup() {
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(userAvatar)
        containerView.addSubview(textContainerStack)
        textContainerStack.addArrangedSubview(usernameLabel)
        textContainerStack.addArrangedSubview(detailsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            userAvatar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            userAvatar.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            userAvatar.widthAnchor.constraint(equalTo: userAvatar.heightAnchor),
            userAvatar.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            textContainerStack.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 8),
            textContainerStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            textContainerStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            textContainerStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
    
}

// MARK: Configuration
extension UserInvertedCell: CellViewModel {
        
    func configure(with model: CellModel) {
        if let model = model as? UserInvertedCellModel {
            usernameLabel.text = model.username
            detailsLabel.text = model.details
            if let avatarData = model.avatarData {
                userAvatar.image = UIImage(data: avatarData)?.inverseImage(cgResult: false)
            } else {
                if let url = URL(string: model.avatarUrl) {
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: url) {
                            DispatchQueue.main.async {
                                self.userAvatar.image = UIImage(data: imageData)?.inverseImage(cgResult: false)
                                model.avatarData = imageData
                            }
                        }
                    }
                }
            }
        }
    }
    
}
