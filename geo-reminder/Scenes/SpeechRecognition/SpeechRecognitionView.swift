//
//  SpeechRecognitionView.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 15.08.2022.
//

import UIKit
import SnapKit

class SpeechRecognitionView: UIView {

    //MARK: - Public properties
    var didPressStopButton: (() -> Void)?
    
    //MARK: - Visual components
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Label"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.addTarget(self, action: #selector(stopButtonTap(_:)), for: .touchUpInside)
        return button
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
    @objc func stopButtonTap(_ sender: UIButton) {
        didPressStopButton?()
    }

    // MARK: - Private methods
    private func addSubviews() {
        addSubview(label)
        addSubview(stopButton)
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(26)
        }
        stopButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(50)
        }
    }

}
