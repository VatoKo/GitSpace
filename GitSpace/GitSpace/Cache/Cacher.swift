//
//  Cacher.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 24.04.21.
//

import Foundation
import CoreData

protocol CoreDataStorable {
    associatedtype ManagedObject
    var id: Int { get set }
    func toManagedObject(with context: NSManagedObjectContext) -> ManagedObject
}

protocol CoreDataConvertible {
    associatedtype Entity
    func toEntity() -> Entity
}

class Cacher<ManagedEntity, Entity> where ManagedEntity: NSManagedObject,
                                          ManagedEntity: CoreDataConvertible,
                                          Entity: CoreDataStorable
{
    
    var container: NSPersistentContainer?
    
    init(with container: NSPersistentContainer) {
        self.container = container
    }
    
    init() {}
    
    func storeInCache(contentsOf array: [Entity]) {
        container?.performBackgroundTask({ (context) in
            context.perform {
                self.fetchFromCache { storedEntities in
                    array.forEach { entity in
                        if !storedEntities.contains(where: { item -> Bool in item.id == entity.id }) {
                            _ = entity.toManagedObject(with: context)
                        }
                    }
                    try? context.save()
                }
            }
        })
    }
    
    func fetchFromCache(completion: ((_ entities: [Entity]) -> ())?) {
        let request = ManagedEntity.fetchRequest()
        guard let storedEntities = try? container?.viewContext.fetch(request) as? [ManagedEntity] else { return }
        let entities: [Entity] = storedEntities.map { $0.toEntity() as! Entity }
        completion?(entities)
    }
    
}
