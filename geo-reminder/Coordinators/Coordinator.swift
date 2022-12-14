//
//  StartCoordinator.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 07.08.2022.
//

import UIKit

class Coordinator: Coordinatable {
    var childCoordinators = [Coordinatable]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = false
    }
    
    func start() {
        let MapViewController = MapConfigurator().configuredViewController(coordinator: self)
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(MapViewController, animated: false)
    }
    
    func openSpeechToTextRecognitionScreen() {
        let SpeechRecognitionViewController = SpeechRecognitionConfigurator().configuredViewController(coordinator: self)
        navigationController.pushViewController(SpeechRecognitionViewController, animated: true)
    }
    
    func openNotesScreen() {
        let NotesViewController = NotesConfigurator().configuredViewController(coordinator: self)
        navigationController.pushViewController(NotesViewController, animated: true)
    }
}
