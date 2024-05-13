//
//  ViewController.swift
//  iQuiz
//
//  Created by Audrey Kim on 5/9/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let topics = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self is whole class instance of ViewController
        // By setting tableView.delegate to self, you're essentially saying, "Hey tableView, I will
        // handle your delegate methods and interactions, so use me as your delegate." This allows
        // you to implement methods from the UITableViewDelegate protocol within the same class or
        // struct where you've set the delegate, enabling you to customize the behavior of the
        // table view as needed.
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Table View Delegate and Data Source
    
    // Establish number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = topics[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "quiz")
        vc.navigationItem.title = topics[indexPath.row]
        navigationController?.pushViewController(vc, animated: true) // this allows our view to change to our view controller for the quiz we clicked on
        
    }
    
}

