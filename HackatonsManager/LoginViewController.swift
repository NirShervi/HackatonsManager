//
//  LoginViewController.swift
//  HackatonsManager
//
//  Created by Nir Shervi on 21/06/2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTB: UITextField!
    @IBOutlet weak var passTB: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func connect(_ sender: Any) {
      validation()
    }
    @IBAction func createAccount(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signUp")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    func validation(){
        if ((emailTB.text?.isEmpty) == nil){
            print("No text in email field")
            return
        }
        if ((passTB.text?.isEmpty) == nil){
            print("No text in password field")
            return
        }
        login()
    }
    
    func login(){
        Auth.auth().signIn(withEmail: emailTB.text!, password: passTB.text!) { [weak self]authResult, err in
            guard let strongSelft = self else {return}
            if let err = err {
                print(err.localizedDescription)
            }
        }
        self.checkUserInfo()
    }
    
    func checkUserInfo(){
        if Auth.auth().currentUser != nil{
            print(Auth.auth().currentUser?.uid)
        }
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "success")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}
