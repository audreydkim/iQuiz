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
    var currAnswer: Int = -1
    var isResultsPage: Bool = false
    var score: Int = 0
    var numQuestion: Int = 0
    
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var AnswerA: UIButton!
    @IBOutlet weak var AnswerB: UIButton!
    @IBOutlet weak var AnswerC: UIButton!
    @IBOutlet weak var AnswerD: UIButton!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var results: UILabel!
    
    var multipleChoice : [UIButton]?
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        
    }
    @IBAction func answerChosen(_ sender: UIButton) {
        if isResultsPage==false {
            SubmitButton.isEnabled = true
            
            switch sender {
            case let button where button.titleLabel!.text! == AnswerA.titleLabel!.text:
                    button.isSelected = true
                    AnswerB.isSelected = false
                    AnswerC.isSelected = false
                    AnswerD.isSelected = false
                    currAnswer = 0
                case let button where button.titleLabel!.text! == AnswerB.titleLabel!.text:
                    button.isSelected = true
                    AnswerA.isSelected = false
                    AnswerC.isSelected = false
                    AnswerD.isSelected = false
                    currAnswer = 1
                case let button where button.titleLabel!.text! == AnswerC.titleLabel!.text:
                    button.isSelected = true
                    AnswerA.isSelected = false
                    AnswerB.isSelected = false
                    AnswerD.isSelected = false
                    currAnswer = 2
                case let button where button.titleLabel!.text! == AnswerD.titleLabel!.text:
                    button.isSelected = true
                    AnswerA.isSelected = false
                    AnswerC.isSelected = false
                    AnswerB.isSelected = false
                    currAnswer = 3
            default:
                currAnswer = -1
                NSLog("Error has occurred")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = data[quizNum].title + " Quiz"
        displayQuestion()
        displayAnswers()
        SubmitButton.isEnabled = false
        results.isHidden = true
        multipleChoice = [self.AnswerA, self.AnswerB, self.AnswerC, self.AnswerD]
        numQuestion = data[quizNum].questions.count - 1
        //AnswerA.titleLabel?.text = "Youre Mother"
        // Do any additional setup after loading the view.
        self.navigationItem.backButtonTitle = "Back"
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
        answer[0]?.tintColor = .systemBlue
        answer[1]?.tintColor = .systemBlue
        answer[2]?.tintColor = .systemBlue
        answer[3]?.tintColor = .systemBlue
    }
    
    @IBAction func submit(_ sender: UIButton) {
        if isResultsPage == false {
            isResultsPage = true
            results.isHidden = false
            SubmitButton.setTitle("Next", for: .normal)
            AnswerA.isEnabled = false
            AnswerB.isEnabled = false
            AnswerC.isEnabled = false
            AnswerD.isEnabled = false
            // if my answer was right
            let correctAnswer = Int(data[quizNum].questions[questionNum].answer)! - 1
            multipleChoice![correctAnswer].isEnabled = true
            multipleChoice![correctAnswer].tintColor = UIColor.green
            if currAnswer == correctAnswer {
                results.text = "You were right!"
                score += 1
            } else {
                NSLog("\(currAnswer)")
                results.text = "You were wrong. That's okay."
                multipleChoice![currAnswer].isEnabled = true
                multipleChoice![currAnswer].tintColor = UIColor.red
            }
            questionNum += 1
        } else if isResultsPage == true && numQuestion > 0 {
            numQuestion -= 1
            results.isHidden = true
            AnswerA.isEnabled = true
            AnswerB.isEnabled = true
            AnswerC.isEnabled = true
            AnswerD.isEnabled = true
            AnswerA.isSelected = false
            AnswerB.isSelected = false
            AnswerC.isSelected = false
            AnswerD.isSelected = false
            displayQuestion()
            displayAnswers()
            isResultsPage = false
            SubmitButton.setTitle("Submit", for: .normal)
        } else if numQuestion == 0 {
            //performSegue(withIdentifier: "finished", sender: self)
            let totalNumQs : Int = data[quizNum].questions.count
            NSLog("got \(score) / \(totalNumQs)")
            if let vc = storyboard?.instantiateViewController(withIdentifier: "FinishViewController") as? FinishViewController {
                vc.score = score
                vc.total = data[quizNum].questions.count
                navigationController?.pushViewController(vc, animated: true) // this allows our view to change to our view controller for the quiz we clicked on
            }
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        // Get the new view controller using segue.destination.
////        // Pass the selected object to the new view controller.
//        if segue.identifier == "finished" {
//            let destinationVC = segue.destination as? FinishViewController
//            destinationVC?.score = score
//            destinationVC?.total = data[quizNum].questions.count
//        }
//    }
//    

}
