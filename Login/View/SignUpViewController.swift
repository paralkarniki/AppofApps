//
//  SignUpViewController.swift
//  Project-AppofApps
//
//  Created by Nikita Paralkar on 2019-12-05.
//  Copyright © 2019 Nikita Paralkar. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    
    @IBOutlet var genderPicker: UIPickerView!

    var genderData: [String] = [String]()
    @IBOutlet var genderText: UITextField!
     @IBOutlet var nameText: UITextField!
     @IBOutlet var emailText: UITextField!
     @IBOutlet var passwordText: UITextField!
    @IBOutlet var usernameText: UITextField!
    @IBOutlet var reenterPasswordText: UITextField!
    
//allows the user to add in the information for new user
    @IBAction func registerBtn(sender: Any) {
        
        let name = nameText.text;
        let email = emailText.text;
        let password = passwordText.text;
        let username = usernameText.text;
        let reenterpswd = reenterPasswordText.text;
        //makes sure that the entered data is not left empty
        if (name!.isEmpty || email!.isEmpty || password!.isEmpty || username!.isEmpty || reenterpswd!.isEmpty){
            
            return alertDisplay(userMessage: "All fields are required")
       
        }
        //makes sure that the entered data for password is similar to the reentered password
        if(password != reenterpswd){
            
         return alertDisplay(userMessage: "Try again passswords Dont match")
        }
      
        
      
         UserDefaults.standard.set(name, forKey: "name") 
         UserDefaults.standard.set(password, forKey: "password")
         UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.synchronize()
        
        
            var myAlert = UIAlertController(title: "Alert", message: "User Successfully added! Thank You", preferredStyle: .alert)
        
        let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(okAlert)
        
    
    }
    
    func alertDisplay(userMessage:String){
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        
        let okAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
            myAlert.addAction(okAlert)
        
        
    }
//    @IBAction func addUser(sender : Any) {
//        let user : Data = Data.init()
//        user.initWithData(theRow: 0, theName: nameText.text!, theUsername: usernameText.text!, theEmail: emailText.text!, thePassword: passwordText.text!)
//
//        let mainDelegate  = UIApplication.shared.delegate as! AppDelegate
//        let returnCode  = mainDelegate.saveDataToDatabase(user: user)
//
//        var returnMSG : String = "User Added"
//
//        if returnCode == false{
//            returnMSG  = "Person could not be added "
//        }
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Connecting to the Data for the gender
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        
        //Input array of the data entered 
        genderData = ["Male", "Female", "Other" ]
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //Number of columns in the data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //Number of rows in the data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderData.count
    }
    //Data to return for the rows
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderData[row]
    }
    //The selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderText.text = genderData[row]
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
