//
//  QuizModel.swift
//  NewsApp1
//
//  Created by Apple on 01/03/2023.
//

import Foundation


protocol QuizProtocol {
    
    
    func questionsRetrieved(_ questions:[Question])
    
}


class QuizModel {
    
    var delegate:QuizProtocol?

    
    func getquestions() {
        
        
       offlinejson()
    }
    
    
    
    
    
    func getLocalJsonFile() {
        
        //Get the path firstly
        
        
        let path = Bundle.main.path(forResource: "Json1", ofType: "json")
        
        // check apth is not equal to nil
        guard path != nil else {return}
        
        //creat url object from path
        
        let url = URL(filePath: path!)
        
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            
         let arrayQuestions =   try decoder.decode([Question].self, from: data)
            delegate?.questionsRetrieved(arrayQuestions)
        }catch{
            
        }
        
    }
    
    
    func offlinejson() {
        let urlString = "https://codewithchris.com/code/QuestionData.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {return}
        
       let dataTask =    URLSession.shared.dataTask(with: url!) { data, _, error in
            guard error ==  nil,
            data != nil
           else {return}
        do {
            let questions = try JSONDecoder().decode([Question].self, from: data!)
            DispatchQueue.main.async {
                self.delegate?.questionsRetrieved(questions)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        }
        dataTask.resume()
    }
    
 
}
