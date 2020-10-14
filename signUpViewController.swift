//
//  signUpViewController.swift
//  D-CODE
//
//  Created by Ritik Suryawanshi on 08/10/20.
//  Copyright © 2020 Ritik Suryawanshi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseDatabase

class signUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        if password.text != confirmPassword.text {
                                 let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
                                 let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                 
                                 alertController.addAction(defaultAction)
                                 self.present(alertController, animated: true, completion: nil)
                             }
                             else{
                                 Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                                     if error == nil {
                                        
                                      
                                      guard let nameText = self.name.text, !nameText.isEmpty else { return}
                                       
                                          guard let emailText = self.email.text, !emailText.isEmpty else { return}
                                          guard let passwordText = self.password.text, !passwordText.isEmpty else { return}
                                       
                                        
                                       
                                      
                                       //let userReference = ref.child("users").child(uid)
                                       let values = ["name": nameText,"email": emailText, "password": passwordText]
                                       Database.database().reference().child("users").child("\(Auth.auth().currentUser!.uid)").updateChildValues(values) {
                                         (error:Error?, ref:DatabaseReference) in
                                         
                                           if let error = error {
                                           print("Data could not be saved: \(error).")
                                         } else {
                                           print("Data saved successfully!")
                                         }
                                       }
                                        
                                        self.performSegue(withIdentifier: "abc2", sender: nil)
                                     }
                                     else{
                                         let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                                         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                         
                                         alertController.addAction(defaultAction)
                                         self.present(alertController, animated: true, completion: nil)
                                    
                                      
                                  
                                  
                                  
                                  
                          }
                      
                      
                      //guard let uid = Auth.auth().currentUser?.uid else
                      /*{
                          return
                      }*/
                          }
                      
                          }
                      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
