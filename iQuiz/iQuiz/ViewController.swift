//
//  ViewController.swift
//  iQuiz
//
//  Created by Audrey Kim on 5/9/24.
//

import UIKit

struct Quiz : Codable  {
    var title: String
    var desc: String
    var questions: [Question]
}

struct Question : Codable {
    var text: String
    var answer: String
    var answers: [String]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Variables
    let topics: [String] = ["Mathematics", "Marvel Super Heroes", "Science"]
    let icons: [String] = ["brain", "superhero", "testtube"]
    let descriptions: [String] = [
        "How much of a Math wiz are you? Test your knowledge here on our Mathematics Quiz!",
        "How well do you know your Marvel Super Heroes? Test your knowledge here on our Marvel Super Hero Quiz!",
        "Are you a Science nerd? Test your knowledge on our Science Quiz!"
    ]
    let fileName = "myFile.json"
    
    // MARK: - UI Components
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func settingsButton(_ sender: Any) {
        let alert = UIAlertController(title: "Settings go here", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            return
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        title = "Quizzes"
        fetch()
    }
    
    // MARK: - Table View Delegate and Data Source
    
    // Establish number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = getData()
        return data.count
    }
    
    // This method is called by the table view when it needs to display a cell for a specific row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // This line dequeues a reusable cell from the table view's reuse queue. It uses the identifier provided by
        // customCell.identifier to dequeue a cell of the custom class customCell.
        let cell = tableView.dequeueReusableCell(withIdentifier: customCell.identifier, for: indexPath) as! customCell // makes cell be of type customCell custom class that we made, if we don't do this cell will just use generic class that doesn't have the cell.title etc that we would want
        let data = getData()
        cell.title.text = data[indexPath.row].title
        cell.icon.image = UIImage(named: icons[indexPath.row])
        cell.descr.text = data[indexPath.row].desc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController {
            navigationController?.pushViewController(vc, animated: true) // this allows our view to change to our view controller for the quiz we clicked on
        }
    }
    
    // ---------------------------------------------------
    func fetch() {
        NSLog("We fetching")
        DispatchQueue.global().sync {
            NSLog("Inside global().async")
            
            // Issue a GET to https://tednewardsandbox.site44.com/questions.json
            let url = URL(string: "https://tednewardsandbox.site44.com/questions.json")!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    NSLog("\(error)")
                } else {
                    NSLog("We have no error")
                }
                //This Swift code is using a guard statement to check whether the response from a network request is an HTTPURLResponse with a status code indicating success (status code between 200 and 299, inclusive) or is nil as in unsuccessful.
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    NSLog(("Error!"))
                    return // end of fetch function bc there was an error
                }
                
                let string = String(data: data!, encoding: .utf8)!
                NSLog("Data returned is \(string)")
                NSLog("Data type of data: \(type(of: data))")
                
                // This call saves the data from the json we fetched from the internet to a local
                // directory
                self.saveData(data!)
            }
            task.resume()
            NSLog("We Fetched")
            
        }
    }
    
//    func saveData(_ data: Data) {
//        do {
//            // Create's and writes to File
//            let fileManager = FileManager.default
//            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//            let filesInDoc = try fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
//            NSLog("my curr files in document directory: \(filesInDoc)")
//            let fileURL = documentDirectory.appendingPathComponent(fileName)
//            let jsonEncoder = JSONEncoder()
//            let jsonData = try jsonEncoder.encode(data)
//            try jsonData.write(to: fileURL)
//        } catch {
//            NSLog("Error when saving data")
//        }
//    }
    func saveData(_ data: Data) {
        do {
            let fileManager = FileManager.default
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            
            // Check if file exists and handle the case appropriately
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
            try data.write(to: fileURL)
        } catch {
            NSLog("Error when saving data: \(error)")
        }
        
    }
    
//    func getData() -> Array<Quiz> {
//        do {
//            let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//            let fileURL = URL(fileURLWithPath: fileName, relativeTo: fileDirectory)
//            let jsonData = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            return try decoder.decode(Array<Quiz>.self, from: jsonData)
//        } catch {
//            NSLog("Error in getting data from local json file")
//        }
//        NSLog("err")
//    }
    
    func getData() -> [Quiz] {
        do {
            let fileDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            let fileURL = URL(fileURLWithPath: fileName, relativeTo: fileDirectory)
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode([Quiz].self, from: jsonData)
        } catch {
            NSLog("Error in getting data from local JSON file: \(error)")
            // Handle the error appropriately, e.g., return an empty array
            return []
        }
    }
}


