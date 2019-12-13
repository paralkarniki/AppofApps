//
//  PickerViewController.swift
//  FinalProject
//
//  Created by  Nikita Paralkar on 2019-11-21.
//  Copyright © 2019 Matthew Marini. All rights reserved.
//

import UIKit




class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    var completionHandler:((String)-> Int)?
    var passedLocation : String?
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainDelegate.locations.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mainDelegate.locations[row].loc
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let alertController = UIAlertController(title: mainDelegate.locations[row].loc, message: "What would you like to do?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: deleteSavedLoc(alert:))
        let loadAction = UIAlertAction(title: "Go To", style: .default, handler: {
            action in self.loadSavedLoc(action: action, alert: alertController)
        })
        
        alertController.addAction(loadAction)
        alertController.addAction(cancelAction)
        //alertController.addAction(deleteAction)
        
        present(alertController, animated: true)
    }
    
    /*
    func deleteSavedLoc(alert: UIAlertAction!){
        
    }
    */
    func loadSavedLoc(action: UIAlertAction!, alert: UIAlertController!){
        passedLocation = alert.title!
        self.performSegue(withIdentifier: "unwindToMapView", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainDelegate.readDataFromDatabase()
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
