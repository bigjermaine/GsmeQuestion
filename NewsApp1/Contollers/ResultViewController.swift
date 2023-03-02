//
//  ResultViewController.swift
//  NewsApp1
//
//  Created by Apple on 02/03/2023.
//

import UIKit

protocol dimissNextButton {
    func  Dimiss()
    
    
}


class ResultViewController: UIViewController {

    
    @IBOutlet weak var BackView: UIView!
    
    @IBOutlet weak var Result: UILabel!
    
    
    
    @IBOutlet weak var Feedback: UILabel!
    
    
    
    @IBOutlet weak var Dimiss: UIButton!
    
    
    
    
    var Feedback1 = ""
    var Result1 = ""
    var ButtonTitle = ""
    
    var delegate: dimissNextButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Result.text = Result1
        Feedback.text =  Feedback1
        Dimiss.setTitle(ButtonTitle, for: .normal)
    }

     @IBAction func Dimiss(_ sender: Any) {
         self.dismiss(animated: true)
          delegate?.Dimiss()
         
     }
     
}
