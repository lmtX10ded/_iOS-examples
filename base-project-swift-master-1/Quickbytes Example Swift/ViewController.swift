//
//  ViewController.swift
//  Quickbytes Example Swift
//
//  Created by Aaron Brethorst on 9/25/17.
//  Copyright © 2017 Quickbytes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/non-explicit.json") // 1
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in // 4
            guard let data = data else {
                print("Error: \(String(describing: error))") // 5
                return
            }
            
            if let appsList = String.init(data: data, encoding: String.Encoding.utf8) { // 6
                print(appsList) // 7
            }
        } // 2
        task.resume() // 3
    }
}
