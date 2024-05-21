//
//  QuizViewController.swift
//  iQuiz
//
//  Created by Audrey Kim on 5/15/24.
//

import UIKit

class QuizViewController: UIViewController {

    // MARK: - Variables
    static let identifier = "QuizViewController"
    var data: [Quiz] = []
    var quizNum: Int = 0
    var questionNum: Int = 0
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var AnswerA: UIButton!
    @IBOutlet weak var AnswerB: UIButton!
    @IBOutlet weak var AnswerC: UIButton!
    @IBOutlet weak var AnswerD: UIButton!
    
    @IBAction func answerChosen(_ sender: Any) {
        NSLog("i love you and you're trying your best")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = data[quizNum].title + " Quiz"
        displayQuestion()
        displayAnswers()
        //AnswerA.titleLabel?.text = "Youre Mother"
        // Do any additional setup after loading the view.
    }

    func displayQuestion() {
        displayLabel.text = data[quizNum].questions[questionNum].text
    }
    
    func displayAnswers() {
        let answer = [AnswerA, AnswerB, AnswerC, AnswerD]
        var counter = 0
        for text in data[quizNum].questions[questionNum].answers {
            answer[counter]?.setTitle(text, for: .normal)
            counter += 1
        }
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

}
