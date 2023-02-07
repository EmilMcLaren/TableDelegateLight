//
//  NewTableViewController.swift
//  BkProject1
//
//  Created by Emil on 31.07.2022.
//

import UIKit

class NewTableViewController: UITableViewController {

    
    var emojiArr = Emodji(emoji: "", name: "", description: "", isfavourite: false)
    
    
    @IBOutlet weak var descriptionTextF: UITextField!
    @IBOutlet weak var nameTextF: UITextField!
    @IBOutlet weak var emojiTextF: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateSaveBurronState()
    }
    
    // MARK: - func for update interface
    // MARK: - update save bottom for tap
    private func updateUI() {
        emojiTextF.text = emojiArr.emoji
        nameTextF.text = emojiArr.name
        descriptionTextF.text = emojiArr.description
    }
    
//======================================================================================================
    // MARK: - update save bottom for tap
    private func updateSaveBurronState() {
        let emojiF = emojiTextF.text ?? ""
        let nameF = nameTextF.text ?? ""
        let descriptionF = descriptionTextF.text ?? ""
        
        saveButton.isEnabled = !emojiF.isEmpty && !nameF.isEmpty && !descriptionF.isEmpty
    }
    
    
    // MARK: - all texfield to there
    @IBAction func textChange(_ sender: UITextField) {
        updateSaveBurronState()
    }
//======================================================================================================
    
    
    // MARK: - work before close segue, add new string to cell, tap to save
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        
        let emojiSeg = emojiTextF.text ?? ""
        let nameSeg = nameTextF.text ?? ""
        let descriptionSeg = descriptionTextF.text ?? ""
        
        self.emojiArr = Emodji(emoji: emojiSeg, name: nameSeg, description: descriptionSeg, isfavourite: self.emojiArr.isfavourite)
    }
    
    


}
