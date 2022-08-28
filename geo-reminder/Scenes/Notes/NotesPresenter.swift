//
//  NotesPresenter.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 26.08.2022.
//

import UIKit
import AVFoundation

class NotesPresenter: NotesPresentable {
    weak var coordinator: Coordinatable?
    weak var view: NotesViewable!
    lazy var dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager

    // MARK: Properties
    private var data: [NoteEntity]?
    
    init(view: NotesViewable) {
        self.view = view
    }
    
    // MARK: Public methods
    func onViewDidLoad() {
        fetchStoredSources()
        setViewModelsInView()
    }
    
    func handleSelectNote(with index: Int) {
        guard let currentNote = data?[index], let text = currentNote.text else { return }
        self.synthSpeak(text: text)
    }
    
    // MARK: Private methods
    private func fetchStoredSources() {
        guard let notesEntity = dataManager.getAllNotes() else {return}
        data = notesEntity
    }
    
    private func setViewModelsInView() {
        guard let data = data else { return }
        let models = getViewModels(from: data)
        view.set(viewModels: models)
    }
    
    private func getViewModels(from data: [NoteEntity]) -> [NotesCellViewModel] {
        data.map { NotesCellViewModel(noteEntity: $0) }
    }
    
    private func synthSpeak(text: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)

        do {
          disableAVSession()
        }
    }
    
    private func disableAVSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't disable.")
        }
    }
}
