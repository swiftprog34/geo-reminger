//
//  SpeechRecognitionConfigurator.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 15.08.2022.
//

import Foundation

class SpeechRecognitionConfigurator {
    func configuredViewController(coordinator: Coordinatable?) -> SpeechRecognitionViewController {
        let viewController = SpeechRecognitionViewController()
        let presenter = SpeechRecognitionPresenter(view: viewController)
        presenter.coordinator = coordinator
        viewController.presenter = presenter
        return viewController
    }
}
