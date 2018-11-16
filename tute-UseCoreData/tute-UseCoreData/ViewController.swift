//
//  ViewController.swift
//  tute-UseCoreData
//
//  Created by My Computer on 2018-11-15.
//  Copyright © 2018 Kish. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
//    var names: [String] = []
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The List"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    


    // Implement the addName IBAction
    @IBAction func addName(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        //below saveAction will save table data in Array and its temporarily
//        let saveAction = UIAlertAction(title: "Save",
//                                       style: .default) {
//                                        [unowned self] action in
//
//                                        guard let textField = alert.textFields?.first,
//                                            let nameToSave = textField.text else {
//                                                return
//                                        }
//
//                                        self.names.append(nameToSave)
//                                        self.tableView.reloadData()
//        }
        
        //Below save action will save table data in CoreData
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()

        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }


    
}

// MARK: - UITableViewDataSource
// Below class extension is to store table values in Array
//extension ViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView,
//                   numberOfRowsInSection section: Int) -> Int {
//        return names.count
//    }
//
//    func tableView(_ tableView: UITableView,
//                   cellForRowAt indexPath: IndexPath)
//        -> UITableViewCell {
//
//            let cell =
//                tableView.dequeueReusableCell(withIdentifier: "Cell",
//                                              for: indexPath)
//            cell.textLabel?.text = names[indexPath.row]
//            return cell
//    }
//}

//Below class extension is to store table values in CoreData
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        
        return cell
    }
    
}


