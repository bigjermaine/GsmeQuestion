//
//  Question.swift
//  NewsApp1
//
//  Created by Apple on 01/03/2023.
//

import Foundation



struct Question:Codable {
    
    var question:String?
    var answers:[String]?
    var correctAnswerIndex: Int?
    var feedback:String?
    
    
}
