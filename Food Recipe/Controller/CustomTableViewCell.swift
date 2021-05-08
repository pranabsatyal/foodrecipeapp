//
//  CustomTableViewCell.swift
//  Food Recipe
//
//  Created by Pranab Raj Satyal on 5/5/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "cell"
    
    var myImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.clipsToBounds = true
        myImageView.layer.cornerRadius = 10
        return myImageView
    }()
    
    var infoView: UIView = {
        let infoView = UIView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.backgroundColor = UIColor(white: 0.6, alpha: 0.9)
        return infoView
    }()
    
    var healthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
     
        contentView.addSubview(myImageView)
        myImageView.addSubview(infoView)
        infoView.addSubview(textLabel!)
        infoView.addSubview(detailTextLabel!)
        infoView.addSubview(healthLabel)
        
        textLabel?.textColor = .label
        textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        textLabel?.numberOfLines = 2
        
        detailTextLabel?.textColor = .label
        detailTextLabel?.font = .systemFont(ofSize: 16, weight: .medium)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addImageViewConstraints()
        addInfoViewConstraints()
        addTextLabelConstraints()
        addDetailTextLabelConstraints()
        addhealthLabelConstraints()
    }
    
    func addImageViewConstraints() {
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    func addInfoViewConstraints() {
        NSLayoutConstraint.activate([
            infoView.widthAnchor.constraint(equalTo: myImageView.widthAnchor),
            infoView.bottomAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: -10),
            infoView.heightAnchor.constraint(equalTo: myImageView.heightAnchor, multiplier: 0.3),
            infoView.centerXAnchor.constraint(equalTo: myImageView.centerXAnchor)
        ])
    }
    
    func addTextLabelConstraints() {
        textLabel!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel!.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            textLabel!.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 10),
            textLabel!.widthAnchor.constraint(equalTo: infoView.widthAnchor, constant: -10),
            textLabel!.heightAnchor.constraint(equalTo: infoView.heightAnchor, multiplier: 0.25)
        ])
    }
    
    func addDetailTextLabelConstraints() {
        detailTextLabel!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailTextLabel!.leadingAnchor.constraint(equalTo: textLabel!.leadingAnchor),
            detailTextLabel!.topAnchor.constraint(equalTo: textLabel!.bottomAnchor),
            detailTextLabel!.widthAnchor.constraint(equalTo: textLabel!.widthAnchor),
            detailTextLabel!.heightAnchor.constraint(equalTo: textLabel!.heightAnchor)
        ])
    }
    
    func addhealthLabelConstraints() {
        NSLayoutConstraint.activate([
            healthLabel.leadingAnchor.constraint(equalTo: detailTextLabel!.leadingAnchor),
            healthLabel.topAnchor.constraint(equalTo: detailTextLabel!.bottomAnchor),
            healthLabel.widthAnchor.constraint(equalTo: detailTextLabel!.widthAnchor),
            healthLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
