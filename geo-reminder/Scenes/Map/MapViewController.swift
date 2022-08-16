//
//  MapViewController.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 07.08.2022.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, MapViewable, UIGestureRecognizerDelegate {
    
    //MARK: Dependencies
    var presenter: MapPresentable!
    lazy var mapView = view as! MapView
    lazy var map = mapView.map
    var gestureRecognizerLongTap: UILongPressGestureRecognizer?
    
    //MARK: Live cycle
    override func loadView() {
        view = MapView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        let lpgr = UILongPressGestureRecognizer(target: self,
                                                action:#selector(self.handleLongPress))
        lpgr.minimumPressDuration = 1
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.map.addGestureRecognizer(lpgr)
    }
    
    //MARK: Public methods
    func set(location: CLLocation) {
        DispatchQueue.main.async {
            let pin = MKPointAnnotation()
            pin.coordinate = location.coordinate
            self.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.5)), animated: true)
            self.map.addAnnotation(pin)
            self.gestureRecognizerLongTap = self.map.gestureRecognizers![0] as? UILongPressGestureRecognizer
            self.gestureRecognizerLongTap?.delegate = self
        }
    }
    
    // MARK: Private methods
    private func subscribeOnCustomViewActions() {
        //        mapView.didLongTapOnMap = { [unowned self] in
        //                guard let gestureRecognizerLongTap = gestureRecognizerLongTap else {return}
        //                if gestureRecognizerLongTap.state != UIGestureRecognizer.State.ended {
        //                    return
        //                }
        //                else if gestureRecognizerLongTap.state != UIGestureRecognizer.State.began {
        //
        //                    let touchPoint = gestureRecognizerLongTap.location(in: self.map)
        //
        //                let touchMapCoordinate =  self.map.convert(touchPoint, toCoordinateFrom: map)
        //                let annotation = MKPointAnnotation()
        //                    annotation.subtitle = "You long pressed here"
        //                    annotation.coordinate = touchMapCoordinate
        //                self.map.addAnnotation(annotation)
        //                print("Tap")
        //            }
        //        }
    }
    
    @objc private func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        }
        else if gestureRecognizer.state != UIGestureRecognizer.State.began {
            
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            
            let touchMapCoordinate =  self.map.convert(touchPoint, toCoordinateFrom: map)
            let annotation = MKPointAnnotation()
            annotation.subtitle = "You long pressed here"
            annotation.coordinate = touchMapCoordinate
            self.map.addAnnotation(annotation)
            self.presenter.prepareForSpeechRecognition()
        }
    }
    
}
