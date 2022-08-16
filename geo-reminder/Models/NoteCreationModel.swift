//
//  NoteCreationModel.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 15.08.2022.
//

import Foundation

class NoteCreationModel {
    var dateTime: Date?
    var text: String?
    var fileUrl: Data?
    var lon: Float?
    var lat: Float?
    
    init(dateTime: Date? = nil, text: String? = nil, fileUrl: Data? = nil, lon: Float? = nil, lat: Float? = nil ) {
        self.dateTime = dateTime
        self.text = text
        self.fileUrl = fileUrl
        self.lon = lon
        self.lat = lat
    }
}
