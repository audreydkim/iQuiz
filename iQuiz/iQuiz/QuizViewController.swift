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
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var AnswerA: UIButton!
    @IBOutlet weak var AnswerB: UIButton!
    @IBOutlet weak var AnswerC: UIButton!
    @IBOutlet weak var AnswerD: UIButton!
    @IBOutlet weak var SubmitButton: UIButton!
    
    @IBAction func answerChosen(_ sender: UIButton) {
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = data[quizNum].title + " Quiz"
        displayQuestion()
        displayAnswers()
        SubmitButton.isEnabled = false
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
    
    @IBAction func submit(_ sender: Any) {
        NSLog("submit")
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
    

}
