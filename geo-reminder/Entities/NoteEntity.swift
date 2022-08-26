//
//  NoteEntity.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 20.08.2022.
//

import Foundation
import CoreData

class NoteEntity: NSManagedObject {
    class func all(context: NSManagedObjectContext) throws -> [NoteEntity] {
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
    
    class func findOrCreate(_ note: Note, context: NSManagedObjectContext) throws -> NoteEntity {
        
        let request: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        request.predicate = NSPredicate(format: "noteId == %@", note.noteId as CVarArg)
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                assert(fetchResult.count == 1, "Duplicate has beeen found in DB!")
                return fetchResult[0]
            }
        } catch {
            throw error
        }
        
        let noteEntity = NoteEntity(context: context)
        noteEntity.noteId = note.noteId
        noteEntity.dateTime = note.dateTime
        noteEntity.text = note.text
        noteEntity.lon = note.lon ?? .zero
        noteEntity.lat = note.lat ?? .zero
        
        return noteEntity
    }
}
