//
//  ContactsTableViewCell.swift
//  TestTask
//
//  Created by Eldor Makkambayev on 6/12/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    var name_surname = UILabel()
//    var surname = UILabel()
    var photo = UIImageView()
    var gender = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension ContactsTableViewCell: ViewInstalation{
    func addSubviews() {
        contentView.addSubview(name_surname)
//        contentView.addSubview(surname)
        contentView.addSubview(photo)
        contentView.addSubview(gender)

    }
    
    func addConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        name_surname.translatesAutoresizingMaskIntoConstraints = false
        photo.translatesAutoresizingMaskIntoConstraints = false
        gender.translatesAutoresizingMaskIntoConstraints = false
        
        layoutConstraints = [
            photo.widthAnchor.constraint(equalToConstant: 60),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            photo.heightAnchor.constraint(equalToConstant: 60),

            name_surname.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            name_surname.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 16),
            name_surname.centerYAnchor.constraint(equalTo: photo.centerYAnchor, constant: -16),
            
            gender.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            gender.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 16),
            gender.centerYAnchor.constraint(equalTo: photo.centerYAnchor, constant: 8),
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func stylizeViews() {
        photo.layer.cornerRadius = 30
        photo.layer.masksToBounds = true
        
        name_surname.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        gender.textColor = .darkGray
        gender.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    
}
