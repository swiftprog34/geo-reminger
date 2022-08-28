//
//  NotesContract.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 26.08.2022.
//

import Foundation

protocol NotesViewable: AnyObject {
    func set(viewModels: [NotesCellViewModel])
}

protocol NotesPresentable: AnyObject {
    func onViewDidLoad()
    func handleSelectNote(with index: Int)
}

protocol Reusable: AnyObject {}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
