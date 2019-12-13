//
//  LibraryTableViewController.swift
//  project
//
//  Created by  Nikita Paralkar  on 11/29/19.
//  Copyright © 2019 Vandan Inc. All rights reserved.
//

import WatchKit


class LibraryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    
    @IBAction func unwindToLibrary(sender: UIStoryboardSegue)
    {
        
    }
    
    var library = MusicLibrary().library
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        tableCell.primaryLabel.text = "Song: " + library[indexPath.row]["title"]!
        tableCell.secondaryLabel.text = "Artist: " + library[indexPath.row]["artist"]!
        
        if let coverImage = library[indexPath.row]["coverImage"]{
            tableCell.myImageView.image = UIImage(named: "\(coverImage).jpg")
        }
        
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        mainDelegate.selectedIndex = library[indexPath.row]["index"]!
        mainDelegate.selectedImage = library[indexPath.row]["coverImage"]!
        mainDelegate.selectedSong = library[indexPath.row]["title"]!
        mainDelegate.selectedArtist = library[indexPath.row]["artist"]!
        performSegue(withIdentifier: "showPlayer", sender: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

}
