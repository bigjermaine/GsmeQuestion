//
//  ViewController.swift
//  NewsApp1
//
//  Created by Apple on 01/03/2023.
//

import UIKit

class ViewController: UIViewController,QuizProtocol,UITableViewDelegate,UITableViewDataSource, dimissNextButton{
    
   
    
    
    var model = QuizModel()
    var questions:[Question] = []
    var currentIndex = 0
    var numbercorrect = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
  var resultDialogue:ResultViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate  = self
        model.getquestions()
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        
        resultDialogue = storyboard?.instantiateViewController(withIdentifier: "ResultVc") as? ResultViewController
        
        resultDialogue?.modalPresentationStyle = .popover
    }
    
    
    
    
    
    func displayQuestion() {
        guard questions.count > 0 && currentIndex < questions.count else {return}
        
        questionLabel.text  = questions[currentIndex].question
    }
    
    func questionsRetrieved(_ questions: [Question]) {
    
            self.questions = questions
        
        
        displayQuestion()
        
        
      let savedindex =  StateManager.retrieveValue(key: StateManager.quizNumberCorrectKey) as? Int
       
        
        guard savedindex == nil else {return}
        
        if savedindex != nil  && savedindex! < currentIndex {
            currentIndex = savedindex!
            
            numbercorrect = StateManager.retrieveValue(key: StateManager.numberCorrectKey) as? Int ?? 0
           
        }
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        let label = cell.viewWithTag(1) as? UILabel
        
        if label != nil && indexPath.row < questions[currentIndex].answers!.count {
            
            label?.text = questions[currentIndex].answers?[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        guard questions.count > 0 else {
            return 0
            
        }
        
        
        
        let currentquestion = questions[currentIndex]
        
        if currentquestion.answers != nil {
            return currentquestion.answers!.count
        }else {
            return  0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var question = questions[currentIndex].correctAnswerIndex
        var titleText = ""
        
        if question == indexPath.row {
            titleText = "Correct!"
            numbercorrect += 1
            
        }else {
            titleText = "Wrong"
            if numbercorrect > 1 {
                numbercorrect -= 1
            }else if numbercorrect == 0 {
               numbercorrect = 0
            }
        }
        
        
        if    resultDialogue != nil {
           
            
            resultDialogue?.Result1 = titleText
            resultDialogue?.ButtonTitle = "Next"
            resultDialogue?.Feedback1   = questions[currentIndex].feedback!
            present(resultDialogue!, animated: true)
        }
        
        resultDialogue?.delegate = self
       
        displayQuestion()
        tableView.reloadData()
        
    }
    
    
    func Dimiss() {
        currentIndex += 1
        if currentIndex  == questions.count {
            let titletext  = "Summary"
            
            if    resultDialogue != nil {
               
                
                resultDialogue?.Result1   = titletext
                resultDialogue?.ButtonTitle = "Restart"
                resultDialogue?.Feedback1   =   "you got \(numbercorrect) out \(questions.count)"
                present(resultDialogue!, animated: true)
                StateManager.clearstate()
            }
            
        }else if currentIndex < questions.count {
            displayQuestion()
            tableView.reloadData()
            StateManager.saveState(numCorrect: numbercorrect, questionindex: currentIndex)
        }else if currentIndex >  questions.count{
            numbercorrect = 0
            currentIndex  = 0
            displayQuestion()
        }
       
    }
    
}

