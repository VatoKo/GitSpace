//  
//  UserProfileController.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import UIKit

class UserProfileController: UIViewController {
    
    // MARK: Internal Components
    
    var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let avatarContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let connectionsContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 32
        return stack
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        
        label.text = "Followers: 123"
        
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        
        label.text = "Following: 145"
        
        return label
    }()
    
    private let infoContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    private let infoContainerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.spacing = 8
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let companyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let blogLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let notesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .heavy)
        label.text = "Notes:"
        return label
    }()
    
    private let noteInput: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 13, weight: .regular)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
        return textView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    var presenter: UserProfilePresenter?
    
    // MARK: Initializer
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        let configurator = UserProfileConfiguratorImpl()
        configurator.configure(self, username: username)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UIViewController Lifecycle
extension UserProfileController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnBlankTap()
        addKeyboardNotificationListeners()
        setupKeyboardResponsiveLayout()
        setup()
        presenter?.viewDidLoad()
    }
    
}

// MARK: Setup
extension UserProfileController {
    
    private func setup() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = String()
        navigationController?.setNavigationBarHidden(false, animated: true)
        addSubviews()
        setupConstraints()
        addTargets()
    }
    
    private func addSubviews() {
        contentView.addSubview(avatarContainerView)
        avatarContainerView.addSubview(avatarImage)
        contentView.addSubview(connectionsContainerStack)
        connectionsContainerStack.addArrangedSubview(followersLabel)
        connectionsContainerStack.addArrangedSubview(followingLabel)
        contentView.addSubview(infoContainerView)
        infoContainerView.addSubview(infoContainerStack)
        infoContainerStack.addArrangedSubview(nameLabel)
        infoContainerStack.addArrangedSubview(companyLabel)
        infoContainerStack.addArrangedSubview(blogLabel)
        contentView.addSubview(notesTitleLabel)
        contentView.addSubview(noteInput)
        contentView.addSubview(saveButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            avatarContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            avatarContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
        ])
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: avatarContainerView.topAnchor, constant: 4),
            avatarImage.bottomAnchor.constraint(equalTo: avatarContainerView.bottomAnchor, constant: -4),
            avatarImage.leadingAnchor.constraint(equalTo: avatarContainerView.leadingAnchor, constant: 4),
            avatarImage.trailingAnchor.constraint(equalTo: avatarContainerView.trailingAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            connectionsContainerStack.topAnchor.constraint(equalTo: avatarContainerView.bottomAnchor, constant: 8),
            connectionsContainerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            connectionsContainerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoContainerView.topAnchor.constraint(equalTo: connectionsContainerStack.bottomAnchor, constant: 8),
            infoContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            infoContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            infoContainerStack.topAnchor.constraint(equalTo: infoContainerView.topAnchor, constant: 4),
            infoContainerStack.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: -4),
            infoContainerStack.leadingAnchor.constraint(equalTo: infoContainerView.leadingAnchor, constant: 4),
            infoContainerStack.trailingAnchor.constraint(equalTo: infoContainerView.trailingAnchor, constant: -4),
        ])
        
        NSLayoutConstraint.activate([
            notesTitleLabel.topAnchor.constraint(equalTo: infoContainerView.bottomAnchor, constant: 16),
            notesTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            noteInput.topAnchor.constraint(equalTo: notesTitleLabel.bottomAnchor, constant: 4),
            noteInput.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            noteInput.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            noteInput.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: noteInput.bottomAnchor, constant: 16),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addTargets() {
        saveButton.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    }
    
}

// MARK: Touch Events
extension UserProfileController {
    
    @objc
    private func saveButtonDidTap() {
        print("Save button did tap")
    }
    
}

extension UserProfileController: UserProfileView {
    
    var pageTitle: String {
        get { title ?? "" }
        set { title = newValue }
    }
    
    func configure(with profileInfo: GithubUserProfileEntity) {
        if let url = URL(string: profileInfo.avatar_url) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.avatarImage.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        followersLabel.text = "Followers: \(profileInfo.followers)"
        followingLabel.text = "Following: \(profileInfo.following)"
        
        nameLabel.text = "Name: \(profileInfo.name)"
        companyLabel.text = "Company: \(profileInfo.company ?? "N/A")"
        blogLabel.text = "Blog: \(profileInfo.blog.isEmpty ? "N/A" : profileInfo.blog)"
    }
    
}

extension UserProfileController: KeyboardResponsive {
    
    var keyboardAlignedToView: UIView {
        return saveButton
    }
    
}
