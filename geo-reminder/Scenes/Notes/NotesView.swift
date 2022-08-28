//
//  NotesView.swift
//  geo-reminder
//
//  Created by Виталий Емельянов on 26.08.2022.
//

import UIKit
import SnapKit

class NotesView: UIView {
    // MARK: - Constants
    private enum Constants {
    }
    
    //MARK: - Visual components
    lazy var notesTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        let cellId = NotesTableViewCell.reuseIdentifier
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 130, right: 0)
        return tableView
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
    
    // MARK: - Actions

    
    // MARK: - Private methods
    private func addSubviews() {
        addSubview(notesTableView)
    }
    
    private func setupConstraints() {
        notesTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
