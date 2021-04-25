//
//  NotesUseCase.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import Foundation

protocol NotesUseCase {
    func fetchNotes(completion: @escaping NotesCompletion)
    func addNote(_ note: NoteEntity)
}

struct NotesUseCaseImpl: NotesUseCase {
    
    private let gateway: NotesGateway
    
    init(gateway: NotesGateway) {
        self.gateway = gateway
    }
    
    func fetchNotes(completion: @escaping NotesCompletion) {
        gateway.fetchNotes(completion: completion)
    }
    
    func addNote(_ note: NoteEntity) {
        gateway.addNote(note)
    }
}
