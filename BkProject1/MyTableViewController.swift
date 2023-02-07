//
//  MyTableViewController.swift
//  BkProject1
//
//  Created by Emil on 31.07.2022.
//

import UIKit

class MyTableViewController: UITableViewController{

    
    var object = [
        Emodji(emoji: "🥰", name: "Love", description: "LoveLoveLove", isfavourite: false),
        Emodji(emoji: "⚽️", name: "Football", description: "FootballFootballFootball", isfavourite: false),
        Emodji(emoji: "🚘", name: "Car", description: "CarCarCarCar", isfavourite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Navigation"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        // MARK: - forgot this!
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // MARK: see up
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    }

    
    // MARK: - Insert new element when tap to save(source for return to second)
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else {return}
        
        let sourceVC = segue.source as! NewTableViewController
        let emoji = sourceVC.emojiArr
        
        // MARK: - for update cell
        if let selectedINdPath = tableView.indexPathForSelectedRow {
            object[selectedINdPath.row] = emoji
            tableView.reloadRows(at: [selectedINdPath], with: .fade)
        } else {
            // MARK: - add new stroke
            let newIndexPath = IndexPath(row: object.count, section: 0)
            // MARK: - add new element to stroke and table
            object.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    
    // MARK: - prepare edit a segue content (slozhno poka)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else {return}
        
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = object[indexPath.row]
        let navigateVC = segue.destination as! UINavigationController
        let newEmojiVC = navigateVC.topViewController as! NewTableViewController
        newEmojiVC.emojiArr = emoji
        newEmojiVC.title = "Edit"
    }
    
    
    //MARK: count tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    //MARK: count rows in tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return object.count
    }

    //MARK: set cell and this objects from array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        let objectLab = object[indexPath.row]
        cell.set(objectiv: objectLab)

        return cell
    }
    
    
    //MARK: choose action to cell
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
//        if indexPath.row % 2 == 0 {
//            return .delete
//        } else {
//            return .insert
//        }
    }
    
    
    //MARK: make action to cell (starting lev)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            object.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: add canmove (up down) for cell
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    //MARK: remove and insert index of object in array(massive) move up
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveObj = object.remove(at: sourceIndexPath.row)
        object.insert(moveObj, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    

//===========================================================================================================
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //MARK: make object action to cell
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        //MARK: add swipe action to cell
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
    
    //MARK: make func for done action in cell (swipe from left)
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { action, view, completion in
            self.object.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    
    
    //MARK: make func for favourite action in cell(swipe from left)
    func favouriteAction (at indexPath: IndexPath) -> UIContextualAction {
        var object = object[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Favourite") { action, view, completion in
            object.isfavourite = !object.isfavourite
            self.object[indexPath.row] = object
            completion(true)
        }
        
        action.backgroundColor = object.isfavourite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
//======================================================================================================
