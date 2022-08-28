//
//  NotesCellViewModel.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 28.08.2022.
//

import Foundation

struct NotesCellViewModel {
    var dateTime: Date
    var text: String
    var lon: Double
    var lat: Double
    
    init(noteEntity: NoteEntity) {
        self.text = noteEntity.text ?? "No text"
        self.dateTime = noteEntity.dateTime ?? Date()
        self.lon = noteEntity.lon
        self.lat = noteEntity.lat
    }

}
