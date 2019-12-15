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
    
    @IBOutlet weak var Switch: UISwitch!
    
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
            var Name = nameTextField.text!
            var Age = ageTextField.text!
            var Gender = genderTextField.text!
            var Weight = weightTextField.text!
            var Height = heightTextFeild.text!
            
            var db = Firestore.firestore()
            if(Switch.isOn){
                var  data =  [
                    "name": Name,
                    "age": Age,
                    "gender": Gender,
                    "weight" : Weight+"pd",
                    "height" : Height+"in"]
                
                db.collection("BMI").document("Values").setData(data) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        var wei = Double(Weight)
                        var hei = Double(Height)
                        var finalval = Double(wei!*703/(hei!*hei!))
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd.MM.yyyy"
                        let result = formatter.string(from: date)
                        var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
                        
                        db.collection("Track").document(timestamp).setData([
                            "date": result,
                            "weight" : Weight+"pd",
                            "height" : Height+"in",
                            "bmi" : ""+String (format: "%.\(3)f",finalval)+" pd/in2",
                            "timestamp" : timestamp
                        ]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                                
                            }else{
                                self.BMIValue.text = String(finalval)
                                
                            }
                            
                            
                            
                        }
                    }
                }
            }
            else{
                var  data =  [
                    "name": Name,
                    "age": Age,
                    "gender": Gender,
                    "weight" : Weight+"kg",
                    "height" : Height+"m"]
                
                db.collection("BMI").document("Values").setData(data) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        var wei = Double(Weight)
                        var hei = Double(Height)
                        var finalval = Double(wei!/(hei!*hei!))
                        let date = Date()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd.MM.yyyy"
                        let result = formatter.string(from: date)
                        var timestamp = String(Int64(Date().timeIntervalSince1970*1000))
                        
                        db.collection("Track").document(timestamp).setData([
                            "date": result,
                            "weight" : Weight+"kg",
                            "height" : Height+"m",
                            "bmi" : ""+String (format: "%.\(3)f",finalval)+" kg/m2",
                            "timestamp" : timestamp
                        ]) { err in
                            if let err = err {
                                print("Error writing document: \(err)")
                                
                            }else{
                                self.label.text = "Metric Units"
               
                                            
               
               if finalval<16
               {
                   self.BMIMessage.text = "Severe Thinness"
               }
               else if finalval>16 && finalval<17
               {
                   self.BMIMessage.text = "Moderate Thinness"
               }
               else if finalval>17 && finalval<18
               {
                  self.BMIMessage.text = "Mild Thinness"
               }
               else if finalval>18 && finalval<25
               {
                   self.BMIMessage.text = "Normal"
               }
               else if finalval>25 && finalval<30
               {
                   self.BMIMessage.text = "Overweight"
               }
               else if finalval>30 && finalval<35
               {
                   self.BMIMessage.text = "Overweight class 1"
               }
               else if finalval>35 && finalval<40
               {
                self.BMIMessage.text = "Overweight Class 2"
               }
               else if finalval>40
               {
                self.BMIMessage.text = "Overweight Class 3"
               }
           }
           
                                
                            }
                        }
                    }
                }
            }
        }
    

