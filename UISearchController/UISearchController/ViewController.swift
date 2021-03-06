//
//  ViewController.swift
//  UISearchController
//
//  Created by Anupam Chugh on 25/05/17.
//  Copyright © 2017 JournalDev.com. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var models = [Model]()
    var filteredModels = [Model]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.tableFooterView = UIView()
        
        setupSearchController()
        
        models = [
            Model(movie:"The Dark Night", genre:"Action"),
            Model(movie:"The Avengers", genre:"Action"),
            Model(movie:"Logan", genre:"Action"),
            Model(movie:"Shutter Island", genre:"Thriller"),
            Model(movie:"Inception", genre:"Thriller"),
            Model(movie:"Titanic", genre:"Romance"),
            Model(movie:"La la Land", genre:"Romance"),
            Model(movie:"Gone with the Wind", genre:"Romance"),
            Model(movie:"Godfather", genre:"Drama"),
            Model(movie:"Moonlight", genre:"Drama")
        ]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let model: Model
        if searchController.isActive && searchController.searchBar.text != "" {
            model = filteredModels[indexPath.row]
        } else {
            model = models[indexPath.row]
        }
        cell.textLabel!.text = model.movie
        cell.detailTextLabel!.text = model.genre
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredModels.count
        }
        
        return models.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func setupSearchController() {
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(white: 0.9, alpha: 0.9)
        searchController.searchBar.placeholder = "Search by movie name or genre"
        searchController.hidesNavigationBarDuringPresentation = false
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    
    
    func filterRowsForSearchedText(_ searchText: String) {
        filteredModels = models.filter({( model : Model) -> Bool in
            return model.movie.lowercased().contains(searchText.lowercased())||model.genre.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }

    
    
}
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }
}


