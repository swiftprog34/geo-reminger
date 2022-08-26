//
//  Note.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 20.08.2022.
//

import Foundation

class Note {
    var dateTime: Date?
    var text: String?
    var lon: Double?
    var lat: Double?
    var noteId: UUID
    
    init(noteId: UUID = UUID(), dateTime: Date? = nil, text: String? = nil, lon: Double? = nil, lat: Double? = nil ) {
        self.noteId = noteId
        self.dateTime = dateTime
        self.text = text
        self.lon = lon
        self.lat = lat
    }
}
