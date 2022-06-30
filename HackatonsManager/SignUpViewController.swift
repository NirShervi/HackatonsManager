//
//  SignUpViewController.swift
//  HackatonsManager
//
//  Created by Nir Shervi on 21/06/2022.
//

import UIKit
import Firebase
import FirebaseAuth
class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTBSignUp: UITextField!
    @IBOutlet weak var passTBSignUp: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        print ("\(emailTBSignUp.text)         \(passTBSignUp.text)")
        if ((emailTBSignUp.text?.isEmpty) == nil){
            print("No text in email field")
            return
        }
        if ((passTBSignUp.text?.isEmpty) == nil){
            print("No text in password field")
            return
        }
        signUp()
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "success")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
        
    }
    @IBAction func moveToLogin(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        present(vc, animated: true)
    }
    
    func signUp(){
        Auth.auth().createUser(withEmail: emailTBSignUp.text!, password: passTBSignUp.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else{
                print("error \(error?.localizedDescription)")
                return
            }
        }
        }
}
