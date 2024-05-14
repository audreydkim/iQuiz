//
//  ViewController.swift
//  iQuiz
//
//  Created by Audrey Kim on 5/9/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    let topics: [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    let icons: [String] = ["brain", "superhero", "testtube"]
    let descriptions: [String] = [
        "How much of a Math wiz are you? Test your knowledge here on our Mathematics Quiz!",
        "How well do you know your Marvel Super Heroes? Test your knowledge here on our Marvel Super Hero Quiz!",
        "Are you a Science nerd? Test your knowledge on our Science Quiz!"
    ]
    
    // MARK: - UI Components
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quizzes"
        let nib = UINib(nibName: "customCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: customCell.identifier)
        
        // self is whole class instance of ViewController
        // By setting tableView.delegate to self, you're essentially saying, "Hey tableView, I will
        // handle your delegate methods and interactions, so use me as your delegate." This allows
        // you to implement methods from the UITableViewDelegate protocol within the same class or
        // struct where you've set the delegate, enabling you to customize the behavior of the
        // table view as needed.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Table View Delegate and Data Source
    
    // Establish number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    // This method is called by the table view when it needs to display a cell for a specific row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // This line dequeues a reusable cell from the table view's reuse queue. It uses the identifier provided by
        // customCell.identifier to dequeue a cell of the custom class customCell.
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.identifier, for: indexPath) as! customCell // makes cell be of type customCell custom class that we made, if we don't do this cell will just use generic class that doesn't have the cell.title etc that we would want
        
        cell.title.text = topics[indexPath.row]
        cell.icon.image = UIImage(named: icons[indexPath.row])
        cell.descr.text = descriptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "quiz")
        vc.navigationItem.title = topics[indexPath.row]
        navigationController?.pushViewController(vc, animated: true) // this allows our view to change to our view controller for the quiz we clicked on
        
    }
    
}

