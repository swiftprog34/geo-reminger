//
//  NotesTableViewCell.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 28.08.2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell, Reusable {
    
    // MARK: Constants
    private enum Constants {
    }
    
    // MARK: Visual components
    lazy var recognitionTextLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Текст напоминания"
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: Initializiers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: Public methods
    func setup(by model: NotesCellViewModel) {
        recognitionTextLabel.text = model.text
    }
    
    // MARK: Private methods
    private func addSubviews() {
        contentView.addSubview(recognitionTextLabel)
    }
    
    private func setupConstraints() {
        recognitionTextLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
