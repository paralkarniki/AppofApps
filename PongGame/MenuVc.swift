//
//  MenuVc.swift
//  AppofApps
//
//  Created by  Nikita Paralkar on 2019-12-06.
//  Copyright © 2019 Vivek Gupta inc. All rights reserved.
//vivek gupta
//[The class for the Menu view controller of the game ]
//This part of code contains 4cases easy,medium,hard and multiplayer that are declared under enum type and
// contains four functions that are connected to their respective buttons to set the difficulty levels
// func moveToGame is the function that takes enum gametype as input and then makes a variable gameVc which instantiate the view controoler with the identifier "gameVC". I have put the storyBoard id of GameViewController as gameVC therefore moveToGame functions instantiates the game controller

import Foundation
import UIKit

enum gameType {
    case easy // for easy difficulty level
    case medium // for medium difficulty level
    case hard // for hard difficulty level
    case player2 // for multiplayer
}

class MenuVC : UIViewController {
    
    @IBAction func UnwindToHomeVC(sender : UIStoryboardSegue){
        // made a story board segue to go back to the main controller of the app
    }
    
    
    @IBAction func Player2(_ sender: Any) {
        moveToGame(game: .player2)
        //set player 2 by putting game = .player 2 and then in 
    }
    
    @IBAction func Easy(_ sender: Any) {
        moveToGame(game: .easy)
    }
    @IBAction func Medium(_ sender: Any) {
        moveToGame(game: .medium)
        
    }
    @IBAction func Hard(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game : gameType) {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
