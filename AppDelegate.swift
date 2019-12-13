//
//  AppDelegate.swift
//  AppofApps
//
//  Created by  Nikita Paralkar on 2019-12-06.
//  Copyright © 2019 Vivek Gupta inc. All rights reserved.
//

import UIKit
import SQLite3
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //Created by Matthew Marini
    var databaseName : String? = "ProjectDatabase.db"
    var databasePath : String?
    var locations : [Data] = []
    
    
    var selectedIndex: String = ""
    var selectedImage: String = ""
    var selectedSong: String = ""
    var selectedArtist: String = ""


    //Created by Matthew Marini
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir = documentPaths[0]
        databasePath = documentsDir.appending("/" + databaseName!)
        
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        return true
    }
    //Created by Matthew Marini
    func readDataFromDatabase(){
        locations.removeAll()
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            
            var queryStatement : OpaquePointer? = nil
            let queryStatementString : String = "select * from locations"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK{
                
                while sqlite3_step(queryStatement) == SQLITE_ROW{
                    
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cloc = sqlite3_column_text(queryStatement, 1)
                    
                    let loc = String(cString : cloc!)
                    
                    let data : Data = Data.init()
                    data.initWithData(theRow: id, theLoc: loc)
                    locations.append(data)
                    
                }
                
                sqlite3_finalize(queryStatement)
                
            }
            else{
                print("SELECT STATEMENT FAILED")
            }
            
            sqlite3_close(db)
            
        }
        else {
            print("FAILED TO OPEN DATABASE")
        }
    }
    //Created by Matthew Marini
    func insertIntoDatabase(location : Data) -> Bool {
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK{
            
            var insertStatement : OpaquePointer? = nil
            let insertStatementString : String = "insert into locations values(NULL, ?)"
            
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                
                let locStr = location.loc! as NSString
                sqlite3_bind_text(insertStatement, 1, locStr.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE{
                    print("SUCCESSFULLY INSERTED")
                }
                else{
                    print("FAILED TO INSERT")
                    returnCode = false
                }
                
                sqlite3_finalize(insertStatement)
                
            }
            else{
                print("INSERT STATEMENT FAILED")
                returnCode = false
            }
            
            sqlite3_close(db)
            
        }
        else{
            print("FAILED TO OPEN DB")
            returnCode = false
        }
        
        return returnCode
    }
    //Created by Matthew Marini
    func checkAndCreateDatabase(){
        var success = false
        let fileManager = FileManager.default
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success {
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

