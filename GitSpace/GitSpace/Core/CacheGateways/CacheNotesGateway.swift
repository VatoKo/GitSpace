//
//  CacheNotesGateway.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import UIKit
import CoreData

struct CacheNotesGateway: NotesGateway {
    
    private let container: NSPersistentContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    func fetchNotes(completion: @escaping NotesCompletion) {
        let cacher = Cacher<Note, NoteEntity>.init(with: container)
        cacher.fetchFromCache { storedEntities in
            completion(.success(storedEntities))
        }
    }
    
    func addNote(_ note: NoteEntity) {
        let cacher = Cacher<Note, NoteEntity>.init(with: container)
        cacher.storeInCache(newObject: note)
    }
    
}
