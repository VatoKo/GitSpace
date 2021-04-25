//
//  NoteEntity.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 25.04.21.
//

import Foundation
import CoreData

struct NoteEntity {
    var id: Int
    let noteText: String
}

extension NoteEntity: CoreDataStorable {
    typealias ManagedObject = Note
    
    func toManagedObject(with context: NSManagedObjectContext) -> Note {
        let noteMo = Note(context: context)
        noteMo.id = Int32(self.id)
        noteMo.noteText = self.noteText
        return noteMo
    }
}
