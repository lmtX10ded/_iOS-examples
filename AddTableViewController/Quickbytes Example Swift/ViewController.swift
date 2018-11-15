//
//  ViewController.swift
//  Quickbytes Example Swift
//
//  Created by Aaron Brethorst on 9/25/17.
//  Copyright © 2017 Quickbytes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.tableView.frame = self.view.bounds
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // Cell reuse identifiers help the table view decide which pool of reusable cells an
    // unused cell should be assigned to. If you have a table view that uses multiple types
    // of cells, you'll have one cell reuse identifier per type. For instance, you might
    // have one type of cell that represents a user, which has a label and a picture, and
    // another that represents a piece of contact information for them, like an email address.
    // You could use two different reuse identifiers to differentiate the cells.
    static let cellReuseIdentifier = "identifier"
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // First, we ask the table to 'dequeue' an unused cell that has our reuse identifier.
        // This isn't guaranteed to work. For instance, there might not be any cells created yet.
        var cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellReuseIdentifier)
        
        // Second, we check to see if we were able to dequeue a cell. If we weren't,
        // we create a new cell *using the same reuse identifier we used before.*
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: ViewController.cellReuseIdentifier)
        }
        
        // At this point, we definitely have a cell. Now, we can fill it with whatever
        // information we want to. In this case, we'll set the cell's text label to be
        // the index path for the cell, which is like an address: Section 0, Row 1, etc.
        cell?.textLabel?.text = indexPath.description
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "You Clicked on a Row!", message: indexPath.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
