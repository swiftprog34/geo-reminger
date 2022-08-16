//
//  Coordinable.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 07.08.2022.
//

import UIKit

protocol Coordinatable: AnyObject {
    var childCoordinators: [Coordinatable] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    func openSpeechToTextRecognitionScreen()
    func addChildCoordinator(_ coordinator: Coordinatable)
    func removeChildCoordinator(_ coordinator: Coordinatable)
}

extension Coordinatable {
    func addChildCoordinator(_ coordinator: Coordinatable) {
        for element in childCoordinators {
            if element === coordinator {
                return
            }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinatable) {
        guard !childCoordinators.isEmpty else { return }
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
