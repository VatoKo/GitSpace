//
//  NotesGateway.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import Foundation

typealias NotesCompletion = (_ result: Result<[NoteEntity], Error>) -> Void

protocol NotesGateway {
    func fetchNotes(completion: @escaping NotesCompletion)
    func addNote(_ note: NoteEntity)
}
