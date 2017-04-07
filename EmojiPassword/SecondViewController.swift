//
//  SecondViewController.swift
//  EmojiPassword
//
//  Created by Mat Schmid on 2017-03-08.
//  Copyright © 2017 Mat Schmid. All rights reserved.
//

// This file contains everything related to the emoji keyboard and testing screen.

import UIKit

class SecondViewController: UIViewController {
    //inits
    @IBOutlet weak var firstSlot: UIImageView!
    @IBOutlet weak var secondSlot: UIImageView!
    @IBOutlet weak var thirdSlot: UIImageView!
    @IBOutlet weak var fourthSlot: UIImageView!
    @IBOutlet weak var fifthSlot: UIImageView!
    @IBOutlet weak var sixthSlot: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dataButton: UIButton!
    @IBOutlet weak var systemLabel: UILabel!
    @IBOutlet weak var roundLabel: UIButton!
    
    var slots : [UIImageView] = []
    var currSlot: Int = 0
    var pass : [UIImage] = []
    var numFails: Int = 0
    var completed = false
    
    //add to log function again
    func addToLog(message: String) {
        do {
            let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
            let url = dir.appendingPathComponent("logData.txt")
            try message.appendLineToURL(fileURL: url as URL)
            _ = try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
        }
        catch {
            print("Could not write to file")
        }
        print(message)
    }
    
    //time and date for logging
    func writeTimeAndDate() -> String {
        
        //time, userID, mode (action), event
        let date = NSDate()
        let calendar = NSCalendar.current
        let year = calendar.component(.year, from: date as Date)
        let month = calendar.component(.month, from: date as Date)
        let day = calendar.component(.day, from: date as Date)
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        let seconds = calendar.component(.second, from: date as Date)
        
        
        let timeString = ("\(String(format: "%02d", hour)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
        let dateString = ("\(String(format: "%02d", year))-\(String(format: "%02d", month))-\(String(format: "%02d", day))")
        
        return dateString + " " + timeString
    }
    
    //grab the emoji that is clicked on the keyboard and place it on the screen
    @IBAction func emojiClicked(_ sender: UIButton) {
        if currSlot < 6 {
            slots[currSlot].image = sender.currentImage
            currSlot += 1
            
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), emoji clicked, success")
        }
        else {
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), emoji clicked, error")
        }
    }
    
    //backspace functionality
    @IBAction func backspace(_ sender: UIButton) {
        if currSlot > 0 {
            currSlot -= 1
            slots[currSlot].image = nil
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), deleter char, success")
        }
        else {
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), delete char, error")
        }
    }
    
    //clear all emojis off the screen
    func clear() {
        for i in slots{
            i.image = nil
        }
        currSlot = 0
    }
    
    //submit button, does all the password checking
    @IBAction func checkPassword(_ sender: UIButton) {
        var count : Int = 0
        if currSlot == 6 {
            for i in 0..<slots.count{
                if pass[i] == slots[i].image{
                    count += 1
                }
                else{
                    textLabel.text = "Incorect password"
                    self.numFails += 1
                    addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), submit password attempt #\(numFails), error")
                    clear()
                }
            }
            if count == 6 {
                textLabel.text = "Correct!!!"
                completed = true
                addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), submit password, success")
                for i in slots{
                    i.image = #imageLiteral(resourceName: "Sunglasses")
                }
                roundLabel.setTitle("Next Round", for: .normal)
            }
        }
        else {
            self.numFails += 1
            textLabel.text = "Place 6 emojis"
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), submit password attempt #\(numFails), error")
        }
    }
    
    //next / skip round button
    @IBAction func roundButton(_ sender: UIButton) {
        if completed {
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), next round, success")
        }
        else {
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), skip round, error")
        }
    }
    
    //what gets shown on the screen when it is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slots.append(firstSlot)
        slots.append(secondSlot)
        slots.append(thirdSlot)
        slots.append(fourthSlot)
        slots.append(fifthSlot)
        slots.append(sixthSlot)
        
        roundLabel.setTitle("Skip Round", for: .normal)
        
        switch iteration{
        case 1:
            systemLabel.text = "Facebook"
            systemLabel.textColor = UIColor.blue
        
        case 2:
            systemLabel.text = "Email"
            systemLabel.textColor = UIColor.red
        case 3:
            systemLabel.text = "Bank Account"
            systemLabel.textColor = UIColor.green
        default:
            systemLabel.text = ""
        }
        
    }
}
