//
//  NotesConfigurator.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 26.08.2022.
//

import Foundation

class NotesConfigurator {
    func configuredViewController(coordinator: Coordinatable?) -> NotesController {
        let viewController = NotesController()
        let presenter = NotesPresenter(view: viewController)
        presenter.coordinator = coordinator
        viewController.presenter = presenter
        return viewController
    }
}
