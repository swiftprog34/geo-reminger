//
//  MapPresenter.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 07.08.2022.
//

import UIKit
import CoreLocation

class MapPresenter: NSObject, MapPresentable, CLLocationManagerDelegate {
    
    weak var coordinator: Coordinatable?
    weak var view: MapViewable!
    lazy var manager = CLLocationManager()
    lazy var dataManager = (UIApplication.shared.delegate as! AppDelegate).dataManager
    
    var completion: ((CLLocation) -> Void)?
    //MARK: Initializers
    
    init(view: MapViewable) {
        self.view = view
    }
    
    func onViewDidLoad() {
        getUserLocation { location in
            let data = MapViewModel(
                countOfNotes: self.dataManager.getCountOfNotes(),
                location: location)
            self.view.set(viewModel: data)
        }
    }
    
    func afterViewDidLoad() {
        let countOfNotes = self.dataManager.getCountOfNotes()
        self.view.set(countOfNotes: countOfNotes)
    }
    
    func prepareForSpeechRecognition() {
        self.coordinator?.openSpeechToTextRecognitionScreen()
    }
    
    func countOfNotesLabelTapped() {
        self.coordinator?.openNotesScreen()
    }
    
    //MARK: Private methods
    private func getUserLocation(completion: @escaping ((CLLocation) -> Void)) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    //MARK: Delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
