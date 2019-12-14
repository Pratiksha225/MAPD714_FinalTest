//
//  ViewController.swift
//  MAPD714_FinalTest
//
//  Created by Pratiksha Kathiriya on 2019-12-11.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FirstViewController: UIViewController
{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextFeild: UITextField!
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var BMIValue: UILabel!
    @IBOutlet weak var BMIMessage: UILabel!
    
    var isChecked = true
    
    @IBAction func `switch`(_ sender: UISwitch)
    {
        isChecked = !isChecked
        
        if isChecked
        {
                label.text = "Imperial Units"
                var bmiWeight = 0
                var bmiHeight = 0
                var finalval = 0
                var weight = Int(weightTextField.text!)
                var height = Int(heightTextFeild.text!)
            
                bmiWeight = weight! * 703
                bmiHeight = height! * height!
            
                finalval = bmiWeight / bmiHeight
            
                BMIValue.text = String(finalval)
        }
        
        else
        {
            label.text = "Metric Units"
            var bmiWeight = 0
            var bmiHeight = 0
            var finalval = 0
            var weight = Int(weightTextField.text!)
            var height = Int(heightTextFeild.text!)
                                         
            bmiWeight = weight!
            bmiHeight = height! * height!
                                        
            finalval = bmiWeight / bmiHeight
                                       
            BMIValue.text = String(finalval)
            
            if finalval<16
            {
                BMIMessage.text = "Severe Thinness"
            }
            else if finalval>16 && finalval<17
            {
                BMIMessage.text = "Moderate Thinness"
            }
            else if finalval>17 && finalval<18
            {
                BMIMessage.text = "Mild Thinness"
            }
            else if finalval>18 && finalval<25
            {
                BMIMessage.text = "Normal"
            }
            else if finalval>25 && finalval<30
            {
                BMIMessage.text = "Overweight"
            }
            else if finalval>30 && finalval<35
            {
                BMIMessage.text = "Overweight class 1"
            }
            else if finalval>35 && finalval<40
            {
                BMIMessage.text = "Overweight Class 2"
            }
            else if finalval>40
            {
                BMIMessage.text = "Overweight Class 3"
            }
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
     
    }

    
    @IBAction func SubmitTapped(_ sender: UIButton)
    {
        let Name = nameTextField.text!
        let Gender = genderTextField.text!
        let Age = ageTextField.text!
        let Weight = Double(weightTextField.text!)
        let Height = Double(heightTextFeild.text!)
        
        let db = Firestore.firestore()
        
        db.collection("users").addDocument(data: ["Name": Name, "Gender": Gender, "Age": Age, "Weight": Weight, "Height": Height ]) { (error) in
            
            if error != nil
            {
               // self.showError("Data can not be added")
            }
        
        }
        
    }
    
}
