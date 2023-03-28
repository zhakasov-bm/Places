//
//  PlacesTableViewCell.swift
//  Places
//
//  Created by Bekzhan on 09.12.2022.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureTitleLabel()
        configureSubtitleLabel()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(place: Location) {
        titleLabel.text = place.title
        subtitleLabel.text = place.subtitle
    }
    
    func configureStackView() {
        addSubview(stackView)
        
        setStackViewConstraints()
        stackView.axis         = .vertical
        stackView.distribution = .fillEqually

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    func configureSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}
