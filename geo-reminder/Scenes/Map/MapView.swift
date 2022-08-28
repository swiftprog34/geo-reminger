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
    var didPressCountOfNotes: (() -> Void)?
    
    //MARK: - Visual components
    lazy var map: MKMapView = {
        let map = MKMapView()
        let mapTapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressOnMapEnded(_:)))
        mapTapRecognizer.minimumPressDuration = 1
        mapTapRecognizer.delaysTouchesBegan = true
        map.addGestureRecognizer(mapTapRecognizer)
        map.layer.zPosition = 0
        return map
    }()
    
    lazy var countNotesUILabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Заметок: "
        label.isHidden = true
        label.layer.zPosition = 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(countOfNotesTapped(_:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
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
    
    @objc private func countOfNotesTapped(_ sender: UIButton) {
        didPressCountOfNotes?()
    }
    
    // MARK: - Public methods
    func setup(for countOfNotes: Int) {
        if countOfNotes > 0 {
            countNotesUILabel.isHidden = false
            countNotesUILabel.text = "Заметок: \(countOfNotes)"
        }
    }

    // MARK: - Private methods
    private func addSubviews() {
        addSubview(map)
        addSubview(countNotesUILabel)
    }
    
    private func setupConstraints() {
        map.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        countNotesUILabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(26)
        }
    }
}
