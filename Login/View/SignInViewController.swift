//
//  SignInViewController.swift
//  Project-AppofApps
//
//  Created by Nikita Paralkar on 2019-12-05.
//  Copyright © 2019 Nikita Paralkar. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController{
        

    
        @IBOutlet var usernameText: UITextField!
        @IBOutlet var passwordText: UITextField!
    
    
    @IBAction func connectBtn(sender : Any){
        
        let password = passwordText.text;
        let username = usernameText.text;
        
        var passwordStored = UserDefaults.standard.string(forKey: "password")
         var usernameStored = UserDefaults.standard.string(forKey: "username")
        
        //allows the user to save and retreive back the username and password
        if(usernameStored == username){
            if(passwordStored == password){
                UserDefaults.standard.set(true, forKey: "isUserStored")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
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
        

}
