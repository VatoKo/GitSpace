//  
//  UserProfilePresenter.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import Foundation

protocol UserProfileView: AnyObject {
    var pageTitle: String { get set }
    var noteText: String { get set }
    func configure(with profileInfo: GithubUserProfileEntity)
    func showPopup(title: String?, text: String?)
}

protocol UserProfilePresenter {
    func viewDidLoad()
    func didTapSave()
}

class UserProfilePresenterImpl: UserProfilePresenter {
    
    private weak var view: UserProfileView?
    private var router: UserProfileRouter
    
    private let userProfileUseCase: UserProfileUseCase
    private let cacheNotesUseCase: NotesUseCase
        
    private var username: String
    private var id: Int?
    private var userNotes = [NoteEntity]()
    
    init(
        view: UserProfileView,
        router: UserProfileRouter,
        userProfileUseCase: UserProfileUseCase,
        cacheNotesUseCase: NotesUseCase,
        username: String
    ) {
        self.view = view
        self.router = router
        self.userProfileUseCase = userProfileUseCase
        self.cacheNotesUseCase = cacheNotesUseCase
        self.username = username
    }
    
    func viewDidLoad() {
        loadNotes()
        view?.pageTitle = username
        userProfileUseCase.fetchUserProfileInfo(with: username) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let userProfileInfo):
                    self.view?.configure(with: userProfileInfo)
                    if let note = self.userNotes.first(where: { $0.id == userProfileInfo.id}) {
                        self.view?.noteText = note.noteText
                    }
                    self.id = userProfileInfo.id
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func didTapSave() {
        guard let view = view else { return }
        guard !view.noteText.isEmpty else {
            view.showPopup(title: "Warning", text: "Please enter note to save")
            return
        }
        
        cacheNotesUseCase.addNote(NoteEntity(id: id!, noteText: view.noteText))
        view.showPopup(title: "Success", text: "Note saved")
        NotificationCenter.default.post(name: .notesDidUpdate, object: nil)
    }
    
    private func loadNotes() {
        cacheNotesUseCase.fetchNotes { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let notes):
                self.userNotes = notes
            case .failure(_):
                break
            }
        }
    }
    
}
