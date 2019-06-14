//
//  ViewController.swift
//  TestTask
//
//  Created by Eldor Makkambayev on 6/12/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {
    
    var URL_REQUEST = "http://www.mocky.io/v2/5a488f243000004c15c3c57e"
    
    var contacts = [ContactsModel]()
    var currentContacts = [ContactsModel]()
    var searchedArray = [ContactsModel]()
    var employments = [EmploymentModel]()
    var genderSearcharray = [ContactsModel]()
    var tableView = UITableView()
    var searchBar = UISearchBar()
    
    var selectedGenderType = ""
    var searchText = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Contacts"
        getContacts()
        setupViews()
        
    }
    
    func getContacts(){
        Alamofire.request(self.URL_REQUEST).responseJSON { response in
            let result = response.result
            if let dict = result.value as? [AnyObject]{
                
                for data in dict {
                    self.contacts.append(self.fromData(data: data ))
                    print(self.contacts)
                }
                
                for i in 0..<self.employments.count{
                    self.contacts[i].employment_name = self.employments[i].employment_name
                    self.contacts[i].employment_position = self.employments[i].employment_position
                }
                
                self.tableView.reloadData()
                
            }
            
            self.currentContacts = self.contacts
            self.searchedArray = self.contacts
            self.tableView.reloadData()
            print(self.contacts)
            
        }
    }
    
    private func fromData(data: AnyObject) -> ContactsModel {
        let contacts: ContactsModel = ContactsModel()
        employments.append(fromEmploymentData(data: data["employment"] as AnyObject))
        
        contacts.id = data["id"] as? Int
        contacts.nameAndSurname = "\((data["first_name"] as? String)!) \((data["last_name"] as? String)!)"
        contacts.photo = data["photo"] as? String
        contacts.gender = data["gender"] as? String
        contacts.ip_address = data["ip_address"] as? String
        contacts.email = data["email"] as? String
        
        return contacts
    }
    
    private func fromEmploymentData(data: AnyObject) -> EmploymentModel {
        let employment: EmploymentModel = EmploymentModel()
        employment.employment_name = data["name"] as? String
        employment.employment_position = data["position"] as? String
        
        return employment
    }
    
}

extension ViewController:  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactsTableViewCell
        
        cell.nameAndSurname.text = currentContacts[indexPath.row].nameAndSurname
        cell.gender.text = currentContacts[indexPath.row].gender
        cell.photo.load(fromUrl: currentContacts[indexPath.row].photo!, complation: nil)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBar.endEditing(true)
        let nextVC = ContactDetailViewController()
        let cell = tableView.cellForRow(at: indexPath) as! ContactsTableViewCell
        
        nextVC.nameAndSurname.text = cell.nameAndSurname.text!
        nextVC.gender.text = cell.gender.text!
        nextVC.photo.image = cell.photo.image!
        nextVC.informs.append(currentContacts[indexPath.row].email!)
        nextVC.informs.append(currentContacts[indexPath.row].ip_address!)
        nextVC.informs.append("\(currentContacts[indexPath.row].employment_name!)   -   \(currentContacts[indexPath.row].employment_position!)")
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedArray = contacts
        searchedArray = contacts.filter({ contact -> Bool in
            
            switch searchBar.selectedScopeButtonIndex {
                
            case 0:
                if searchText.isEmpty {currentContacts = contacts; return true }
                return contact.nameAndSurname!.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty { return contact.gender == "Male" }
                return contact.nameAndSurname!.lowercased().contains(searchText.lowercased()) &&
                    contact.gender == "Male"
            case 2:
                if searchText.isEmpty { return contact.gender == "Female" }
                return contact.nameAndSurname!.lowercased().contains(searchText.lowercased()) &&
                    contact.gender == "Female"
            default:
                return false
            }
            
        })
        
        self.searchText = searchText
        currentContacts = searchedArray
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            self.searchBar(searchBar, textDidChange: searchText)
            selectedGenderType = "All"
        case 1:
            self.searchBar(searchBar, textDidChange: searchText)
            selectedGenderType = "Male"
            
        case 2:
            self.searchBar(searchBar, textDidChange: searchText)
            selectedGenderType = "Female"
            
        default:
            break
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchText = ""
        searchBar.text = nil
        if selectedGenderType == "Male" || selectedGenderType == "Female"{
            cancelAction(selectedGenderType)
        }else{
            currentContacts = contacts
        }
        tableView.reloadData()
        
        searchBar.endEditing(true)
    }
    
    func cancelAction(_ gender: String){
        searchedArray = contacts
        currentContacts = searchedArray.filter({ contact -> Bool in
            contact.gender == gender
        })
    }
    
}

extension ViewController: ViewInstalation{
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    func addConstraints(){
        var layoutConstraints = [NSLayoutConstraint]()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        layoutConstraints = [
            
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: (navigationController?.navigationBar.bounds.height)! + UIApplication.shared.statusBarFrame.height),
            searchBar.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    func stylizeViews() {
        
        view.backgroundColor = .white
        
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["All", "Male", "Female"]
        searchBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        searchBar.barTintColor = .white
        searchBar.showsCancelButton = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
}

