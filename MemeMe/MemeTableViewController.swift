//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Najla Awadh on 12/08/1440 AH.
//  Copyright © 1440 Najla Awadh. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    var memes : [Meme]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return self.memes.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return self.memes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell")!
        let meme = memes[indexPath.row]
        
        cell.textLabel?.text = meme.top + "   " + meme.bottom
        cell.imageView?.image = meme.memedImage
        
      
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailCV = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailCV.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailCV, animated: true)
        
    }
    

}
