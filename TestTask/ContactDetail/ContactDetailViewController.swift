//
//  ContactDetailViewController.swift
//  TestTask
//
//  Created by Eldor Makkambayev on 6/13/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var photo = UIImageView()
    var name_surname = UILabel()
    var gender = UILabel()
    var moreInfTabelView = UITableView()
    var types = ["Email", "IP address", "Employment"]
    var informs: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(informs)
        setupViews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreinf", for: indexPath) as! MoreInfTableViewCell
        cell.nameOfInfo.text = informs[indexPath.row]
        cell.typeOfInfo.text = types[indexPath.row]
        return cell
    }
    

}

extension ContactDetailViewController: ViewInstalation{
    func addSubviews() {
        view.addSubview(moreInfTabelView)
        view.addSubview(name_surname)
        view.addSubview(photo)
        view.addSubview(gender)
        
    }
    
    func addConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        name_surname.translatesAutoresizingMaskIntoConstraints = false
        photo.translatesAutoresizingMaskIntoConstraints = false
        gender.translatesAutoresizingMaskIntoConstraints = false
        moreInfTabelView.translatesAutoresizingMaskIntoConstraints = false
        
        layoutConstraints = [
            photo.widthAnchor.constraint(equalToConstant: 60),
            photo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            photo.topAnchor.constraint(equalTo: view.topAnchor, constant: 70 + 8),
            photo.heightAnchor.constraint(equalToConstant: 60),
            
            name_surname.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            name_surname.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 16),
            name_surname.centerYAnchor.constraint(equalTo: photo.centerYAnchor, constant: -16),
            
            gender.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            gender.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 16),
            gender.centerYAnchor.constraint(equalTo: photo.centerYAnchor, constant: 8),
            
            moreInfTabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moreInfTabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moreInfTabelView.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 24),
            moreInfTabelView.heightAnchor.constraint(equalToConstant: 163)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func stylizeViews() {
        
        view.backgroundColor = #colorLiteral(red: 0.9699123792, green: 0.9855318002, blue: 1, alpha: 1)
        
        photo.layer.cornerRadius = 30
        photo.layer.masksToBounds = true
//        photo.image = #imageLiteral(resourceName: "fc45933e-7ecc-42d5-a08c-fa36f1c38047")
        
        name_surname.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        gender.textColor = .gray
        gender.font = UIFont.systemFont(ofSize: 14)
        
        moreInfTabelView.delegate = self
        moreInfTabelView.dataSource = self
        moreInfTabelView.register(MoreInfTableViewCell.self, forCellReuseIdentifier: "moreinf")
        moreInfTabelView.backgroundColor = .white
        moreInfTabelView.layer.borderWidth = 0.5
        moreInfTabelView.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)

    }
    
    
}

