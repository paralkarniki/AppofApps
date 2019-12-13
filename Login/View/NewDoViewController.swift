//
//  NewDoViewController.swift
//  Project-AppofApps
//
//  Created by Nikita Paralkar on 2019-12-05.
//  Copyright © 2019 Nikita Paralkar. All rights reserved.
//

import UIKit


class NewDoViewController: UIViewController {
 
    
    @IBOutlet var input : UITextField!
    
    //addItem functions allows the user to add new items to the list
    @IBAction func addItem(_sender : AnyObject){
    
        if (input.text != " ") {
             list.append(input.text!)
            input.text = "  "
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
