//
//  MoreInfTableViewCell.swift
//  TestTask
//
//  Created by Eldor Makkambayev on 6/13/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MoreInfTableViewCell: UITableViewCell {
    var typeOfInfo = UILabel()
    var nameOfInfo = UILabel()

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

extension MoreInfTableViewCell: ViewInstalation{
    func addSubviews() {
        contentView.addSubview(typeOfInfo)
        //        contentView.addSubview(surname)
        contentView.addSubview(nameOfInfo)
        
    }
    
    func addConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        typeOfInfo.translatesAutoresizingMaskIntoConstraints = false
        nameOfInfo.translatesAutoresizingMaskIntoConstraints = false
        
        layoutConstraints = [
            
            typeOfInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            typeOfInfo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            nameOfInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            nameOfInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameOfInfo.topAnchor.constraint(equalTo: typeOfInfo.bottomAnchor, constant: 4),
            nameOfInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)

        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func stylizeViews() {
        
        nameOfInfo.font = UIFont.systemFont(ofSize: 14)
        
        typeOfInfo.textColor = .darkGray
        typeOfInfo.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    
}
