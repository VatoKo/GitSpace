//
//  Note.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import Foundation
import CoreData

class Note: NSManagedObject {
    
}

extension Note: CoreDataConvertible {
    typealias Entity = NoteEntity
    
    func toEntity() -> NoteEntity {
        let note = NoteEntity(id: Int(id), noteText: noteText!)
        return note
    }
}
