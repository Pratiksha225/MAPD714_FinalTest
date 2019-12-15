//
//  TableViewController.swift
//  MAPD714_FinalTest
//
//  Created by Hemanth Kotla on 2019-12-14.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

import UIKit

import FirebaseFirestore

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Table: UITableView!
    var db:Firestore?
    var path = [[String:AnyObject]]()
    var info = [String:AnyObject]()
    
      
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return path.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = (tableView.dequeueReusableCell(withIdentifier: "infoCell")! as? HistoryCell)!
        
        info = path[indexPath.row]
        cell.Weight.text = info["weight"] as! String
        cell.Date.text = info["date"] as! String
        cell.Bmi.text = info["bmi"] as! String
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete
           {
            var db = Firestore.firestore()
                   db.collection("Measurements").document(String(info["timestamp"] as! String)).delete() { err in
                       if let err = err {
                           print("Error removing document: \(err)")
                       } else {
                           
                       }
                   }
                   
               tableView.reloadData()
               
           }
       }
       
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
   
        getData()
        
    }
    func getData(){
        var db = Firestore.firestore()
        db.collection("Measurements").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.path.removeAll()
                for document in querySnapshot!.documents {
                    self.path.append(document.data() as [String : AnyObject])
                }
                let count = self.path.count
                if(count == 0){
                    db.collection("Records").document("Info").delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            self.performSegue(withIdentifier: "next", sender: nil)
                        }
                    }
                }
                
                self.Table?.reloadData()
            }
        }
        
        
        
    }


    
    

    
}

