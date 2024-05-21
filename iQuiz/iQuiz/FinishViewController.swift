//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Audrey Kim on 5/20/24.
//

import UIKit

class FinishViewController: UIViewController {

    var score: Int?
    var total: Int?
    
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var ResultStatement: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Score.text = String(score!) + "/" + String(total!)
        if score == total {
            ResultStatement.text = "Perfect score!"
        } else {
            ResultStatement.text = "Almost perfect score!"
        }
        self.navigationItem.backButtonTitle = "Back"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func goHome(_ sender: Any) {
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        let temp = navigationArray.first
        navigationArray.removeAll()
        navigationArray.append(temp!) //To remove all previous UIViewController except the last one
        self.navigationController?.viewControllers = navigationArray
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
