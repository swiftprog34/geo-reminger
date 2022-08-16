//
//  MapContract.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 07.08.2022.
//

import Foundation
import CoreLocation

protocol MapViewable: AnyObject {
    func set(location: CLLocation)
}

protocol MapPresentable: AnyObject {
    func onViewDidLoad()
    func prepareForSpeechRecognition()
}
