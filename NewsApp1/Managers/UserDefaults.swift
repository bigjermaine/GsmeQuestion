//
//  UserDefaults.swift
//  NewsApp1
//
//  Created by Apple on 02/03/2023.
//

import Foundation


class StateManager {
    
    static var numberCorrectKey = "NumberCorrectKey"
     
    static var quizNumberCorrectKey = "quizNumberCorrectKey"
    
    
    
    
    static func saveState(numCorrect:Int,questionindex:Int) {
       // Get  a reference to user defaults
        let defaults = UserDefaults.standard
        
        
        defaults.set(numCorrect, forKey: numberCorrectKey)
        defaults.set(questionindex, forKey: quizNumberCorrectKey)
    }
    
    
    
    static func retrieveValue(key:String) -> Any?  {
        // Get  a reference to user defaults
        let defaults = UserDefaults.standard
        
      return  defaults.value(forKey: key)
    }
    
    
    static func clearstate() {
        
        // Get a reference to user
        
        let defaults = UserDefaults.standard
        
        defaults.removeObject(forKey: numberCorrectKey)
        defaults.removeObject(forKey: quizNumberCorrectKey)
        
        
    }
    
    
}
