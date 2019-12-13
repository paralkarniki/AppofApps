//
//  ToDoViewController.swift
//  Project-AppofApps
//
//  Created by Nikita Paralkar on 2019-12-05.
//  Copyright © 2019 Nikita Paralkar. All rights reserved.
//

import UIKit
 var list = ["Finish IOS", "Go to the Bank"]
class ToDoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    

      @IBOutlet var myTableView : UITableView!
    
    //counts the number of items in the list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    //return the selcted item to the list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            list.remove(at: indexPath.row)
            myTableView.reloadData()
        }
        
    }
    //helps reload the list after the user adds in a new item to the list
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
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
