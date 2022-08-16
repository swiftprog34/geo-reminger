//
//  MapView.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 07.08.2022.
//

import UIKit
import SnapKit
import MapKit

class MapView: UIView {

    //MARK: - Public properties
    var didLongTapOnMap: (() -> Void)?
    
    //MARK: - Visual components
    lazy var map: MKMapView = {
        let map = MKMapView()
        let mapTapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressOnMapEnded(_:)))
        mapTapRecognizer.minimumPressDuration = 1
        mapTapRecognizer.delaysTouchesBegan = true
        map.addGestureRecognizer(mapTapRecognizer)
        return map
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Actions
    @objc private func longPressOnMapEnded(_ sender: MKMapView) {
        didLongTapOnMap?()
    }

    // MARK: - Private methods
    private func addSubviews() {
        addSubview(map)
    }
    
    private func setupConstraints() {
        map.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
