//
//  ViewController.swift
//  HackatonsManager
//
//  Created by Nir Shervi on 21/06/2022.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    
    var table = [Hackaton]()
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var searchText: UITextField!
    var ref:DatabaseReference!
    var searchBar : String!
    var isSearching : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database(url: "https://hackatonsmanager-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Hackatons")
        print("Finish Part 1")
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.table.removeAll()
                for hackaton in snapshot.children.allObjects as! [DataSnapshot] {
                    let Object = hackaton.value as? [String : AnyObject]
                    print("\(Object)")
                    let name = Object?["name"] as? String
                    print("**************the name is \(name)********************")
                    let dept = Object?["Dept"] as? String
                    print("**************the dept is \(dept)********************")
                    let date = Object?["date"] as? String
                    print("**************the date is \(date)********************")
                    let theme = Object?["theme"] as? String
                    print("**************the theme is \(theme)********************")
                    let currNumOfParts = Object?["currNumOfParts"] as? String
                    print("**************the currNumOfParts is \(currNumOfParts)********************")
                    let numOfParts = Object?["numOfParts"] as? String
                    print("**************the numOfParts is \(numOfParts)********************")
                    let parts = Object?["parts"] as? String
                    print("**************the parts is \(parts)********************")
                    let hack = Hackaton(hName: name , dept: dept , date: date , theme: theme , numParts: numOfParts , currNumParts: currNumOfParts , parts: parts)
                    if (self.isSearching){
                        if (hack.hName == self.searchBar || hack.theme == self.searchBar || hack.dept == self.searchBar){
                            self.table.append(hack)
                        }
                    }else{
                        self.table.append(hack)
                    }
                    self.TableView.reloadData()
                }
                self.isSearching = false
            }
            
        })
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! TableViewCell
        let hackaton : Hackaton
        print(indexPath)
        hackaton = table[indexPath.row]
        cell.title.text = "Name : \(hackaton.hName!)"
        cell.dept.text = "Department : \(hackaton.dept!)"
        cell.theme.text = "Theme : \(hackaton.theme!)"
        cell.date.text = "Date : \(hackaton.date!)"
        cell.parts.text = "Participants : \(hackaton.currNumParts!) | \(hackaton.numParts!)"
        cell.cellDelegate = self
        cell.index = indexPath
        return cell
    }
    
    @IBAction func searchBar(_ sender: Any) {
        if ((searchText.text?.isEmpty) == nil)
        {
            print("search error%%%%%%%%%%%%%%%%%%%%%%%%%%%")
        }else{
            self.searchBar = searchText.text
            self.isSearching = true
            viewDidLoad()
        }
    }
    
    @IBAction func personalArea(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PA")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}

extension ViewController :TableViewNew {
    
    
    
    func onClickMe(index: Int){
        print("\(index) is After Clicked &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
        var isFull : Bool = false
        var isAlreadyAssigned : Bool = false
        var numOfParts = 0
        var curNumParts = 0
        var partsToWrite = ""
        var counter = 0
        var key = ""
        var userID = "" as String?
        var newParts = ""
        
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.table.removeAll()
                for hackaton in snapshot.children.allObjects as! [DataSnapshot] {
                    if (index == counter){
                        curNumParts = 0
                    let Object = hackaton.value as? [String : AnyObject]
                    print("\(Object)")
                    let currNumOfParts = Object?["currNumOfParts"] as? String
                    print("**************the currNumOfParts is \(currNumOfParts)********************")
                    let numOfParts = Object?["numOfParts"] as? String
                    print("**************the numOfParts is \(numOfParts)********************")
                    let parts = Object?["parts"] as? String
                        partsToWrite = parts!
                    print("**************the parts is \(parts)********************")
                    if (Int(currNumOfParts!)! > Int(numOfParts!)!){
                        isFull = true
                    }
                        curNumParts = Int(currNumOfParts!)!
                        print ("9999999999999999 \(curNumParts)99999999999999\(currNumOfParts)9999999999999")
                    userID = Auth.auth().currentUser?.uid
                    print("\(parts?.contains(userID!))")
                    if (parts?.contains(userID!) == true){
                        isAlreadyAssigned = true
                    }
                        key = hackaton.key
                        print("\(hackaton.key)@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        
                        if (isAlreadyAssigned == false && isFull == false){
                            print("@#$@#$@#$@#$@$@#$@#$@#\(numOfParts)#$%#%#%#$%#$%$#%#$%#%$#$%$##$%")
                            
                            
                        if (Int(numOfParts!) == 0){
                                self.ref.child("\(key)").updateChildValues(["parts":userID])
                            curNumParts = curNumParts + 1
                            print("4444444444444444444\(curNumParts)44444444444444444444")
                            self.ref.child("\(key)").updateChildValues(["currNumOfParts":String(curNumParts)])
                        }
                        else{
                            newParts = (partsToWrite)+(userID!)
                            print("11111111111111111111\(newParts)111111111111111111111")
                            self.ref.child("\(key)").updateChildValues(["parts": newParts])
                            curNumParts = curNumParts + 1
                            print("4444444444444444444\(curNumParts)44444444444444444444")
                            self.ref.child("\(key)").updateChildValues(["currNumOfParts":String(curNumParts)])
                        }
                        }
                    }
                    counter = counter + 1
                }
            }
        })
        self.viewDidLoad()
    }
}

