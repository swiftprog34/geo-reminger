//
//  NotesController.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 26.08.2022.
//

import UIKit

class NotesController: UIViewController, NotesViewable {
    
    // MARK: Dependencies
    var presenter: NotesPresentable!
    
    // MARK: Visual components
    lazy var notesView = view as! NotesView
    lazy var notesTableView = notesView.notesTableView
    
    // MARK: Private properties
    private var data = [NotesCellViewModel]() { didSet { notesTableView.reloadData() } }
    
    // MARK: Life cycle
    override func loadView() {
        view = NotesView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        becomeTableViewDelegate()
        subscribeOnCustomViewActions()
        presenter.onViewDidLoad()
    }
    
    // MARK: Public methods
    func set(viewModels: [NotesCellViewModel]) {
        data = viewModels
    }
    
    // MARK: Private methods
    private func becomeTableViewDelegate() {
        notesTableView.delegate = self
        notesTableView.dataSource = self
    }
    
    private func subscribeOnCustomViewActions() {
        
    }
}

// MARK: - UITableViewDelegate
extension NotesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.handleSelectNote(with: indexPath.row)
//        let detailNote = DetailNoteViewController()
//        detailNote.modalPresentationStyle = .automatic
//        present(detailNote, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension NotesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = NotesTableViewCell.reuseIdentifier
        let cell = notesTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NotesTableViewCell
        let currentData = data[indexPath.row]
        cell.setup(by: currentData)
        return cell
    }
}
