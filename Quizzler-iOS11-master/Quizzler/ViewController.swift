//
//  ViewController.swift
//  Quizzler
//
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNum : Int = 0
    var score : Int = 0
    
    //Place your instance variables here
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
  
        if sender.tag == 1 {
            pickedAnswer = true
        }
        
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNum += 1
        
        nextQuestion()
        
    }
    
    
    func updateUI() {
        
        scoreLabel.text = "Score: \(score)"
        
        if questionNum <= 12 {
            progressLabel.text = "\(questionNum + 1) / 13"
        }
        else {
            progressLabel.text = "\(questionNum) / 13"
        }
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNum + 1)
        
    }

    
    func nextQuestion() {
        
        if questionNum <= 12 {
    
            questionLabel.text = allQuestions.list[questionNum].questionText
            
            updateUI()
        }
        
        else {
            
            updateUI()
        
            let alert = UIAlertController(title: "Quiz Over", message: "Do you want to retake the quiz?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
        }
        
    }
   
    
    func checkAnswer() {
        
        let firstA = allQuestions.list[questionNum].answer
        
        if firstA == pickedAnswer {
            
            ProgressHUD.showSuccess("Correct!")
            
            score += 1
        }
        else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
        
        questionNum = 0
        score = 0
        nextQuestion()
       
    }
   
    
}
