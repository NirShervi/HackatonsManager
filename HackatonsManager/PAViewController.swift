//
//  PAViewController.swift
//  HackatonsManager
//
//  Created by Nir Shervi on 27/06/2022.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore


class PAViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
  
    var table = [Hackaton]()

    @IBOutlet weak var tableView: UITableView!
    

    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")

        ref = Database.database(url: "https://hackatonsmanager-default-rtdb.europe-west1.firebasedatabase.app/").reference().child("Hackatons")
        print("Finish Part 1")
        ref.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount > 0 {
                self.table.removeAll()
                for hackaton in snapshot.children.allObjects as! [DataSnapshot] {
                    let Object = hackaton.value as? [String : AnyObject]
                    print("\(Object)")
                    let name = Object?["name"] as? String
                    print("****????????****the name is \(name)****?????***********")
                    let dept = Object?["Dept"] as? String
                    print("*****????????****the dept is \(dept)******?????*******")
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
                    let arrParts = hack.parts?.split(separator: ",")
                    let userID = Auth.auth().currentUser?.uid as String?
                    print("\(hack.parts?.contains(userID!+""))")
                    if (hack.parts?.contains(userID!+"") == true) {
                    self.table.append(hack)
                    }
                    self.tableView.reloadData()
                }
            }
            
        })
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellPA = tableView.dequeueReusableCell(withIdentifier: "cellPA") as! PATableViewCell
        let hackaton : Hackaton
        hackaton = table[indexPath.row]
        cellPA.title.text = "Name : \(hackaton.hName!)"
        cellPA.dept.text = "Department : \(hackaton.dept!)"
        cellPA.theme.text = "Theme : \(hackaton.theme!)"
        cellPA.date.text = "Date : \(hackaton.date!)"
        cellPA.parts.text = "Participants : \(hackaton.currNumParts!) | \(hackaton.numParts!)"
        return cellPA
    }
    @IBAction func backToHome(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "success")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}
