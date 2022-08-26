//
//  SpeechRecognitionContract.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 15.08.2022.
//

import Foundation

protocol SpeechRecognitionViewable: AnyObject {
    func set(text: String)
    func informUser(title: String, text: String)
}

protocol SpeechRecognitionPresentable: AnyObject {
    func onViewDidLoad()
    func handleAddNote(text: String)
    func afterAddNoteAction()
}
