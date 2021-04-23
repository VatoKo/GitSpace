//
//  UserNotedCell.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 23.04.21.
//

import UIKit

class UserNotedCell: UITableViewCell {
    
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
        imageView.backgroundColor = .lightGray
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
    
    private let noteIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "note")
        return imageView
    }()
    
}

// MARK: UIView Lifecycle
extension UserNotedCell {
    
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
extension UserNotedCell {
    
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
        containerView.addSubview(noteIcon)
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
            textContainerStack.trailingAnchor.constraint(equalTo: noteIcon.leadingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            noteIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            noteIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            noteIcon.widthAnchor.constraint(equalTo: noteIcon.heightAnchor),
            noteIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
}

// MARK: Configuration
extension UserNotedCell: CellViewModel {
        
    func configure(with model: CellModel) {
        if let model = model as? UserNotedCellModel {
            usernameLabel.text = model.username
            detailsLabel.text = model.details
        }
    }
    
}
