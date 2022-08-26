//
//  MapContract.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 07.08.2022.
//

import Foundation
import CoreLocation

protocol MapViewable: AnyObject {
    func set(viewModel: MapViewModel)
    func set(countOfNotes: Int)
}

protocol MapPresentable: AnyObject {
    func onViewDidLoad()
    func afterViewDidLoad()
    func prepareForSpeechRecognition()
    func countOfNotesLabelTapped()
}
