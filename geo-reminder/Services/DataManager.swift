//
//  DataService.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 20.08.2022.
//

import Foundation
import CoreData

class DataManager {
    //MARK: - Private properties
    private lazy var coreDataService = CoreDataService.shared
    private lazy var context = coreDataService.context
    private lazy var persistentContainer = coreDataService.persistentContainer
    
    func createNote(text: String, completion: @escaping (Result<NoteEntity, Error>) -> Void) {
        let note = Note(noteId: UUID(), dateTime: Date(), text: text, lon: 48.0, lat: 48.0)
        do {
            let noteEntity = try NoteEntity.findOrCreate(note, context: context)
            coreDataService.saveContext()
            completion(.success(noteEntity))
        } catch {
            print(error.localizedDescription)
            completion(.failure(error))
        }
    }
    
    func getAllNotes() -> [NoteEntity]? {
        do {
            return try NoteEntity.all(context: context)
        } catch {
            return nil
        }
    }
    
    func getCountOfNotes() -> Int {
        let notes = getAllNotes()
        guard let notes = notes else { return 0 }
        return notes.count
    }
}
