//
//  MapConfigurator.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 07.08.2022.
//

import Foundation

class MapConfigurator {
    func configuredViewController(coordinator: Coordinatable?) -> MapViewController {
        let viewController = MapViewController()
        let presenter = MapPresenter(view: viewController)
        presenter.coordinator = coordinator
        viewController.presenter = presenter
        return viewController
    }
}
