//
//  ThirdViewController.swift
//  EmojiPassword
//
//  Created by Mat Schmid on 2017-03-19.
//  Copyright © 2017 Mat Schmid. All rights reserved.
//

// This file contains everything related to the memory retesting screen.

import UIKit
import GameKit

var iter = 0

class ThirdViewController: UIViewController {
    //inits
    @IBOutlet weak var firstSlot: UIImageView!
    @IBOutlet weak var secondSlot: UIImageView!
    @IBOutlet weak var thirdSlot: UIImageView!
    @IBOutlet weak var fourthSlot: UIImageView!
    @IBOutlet weak var fifthSlot: UIImageView!
    @IBOutlet weak var sixthSlot: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var systemLabel: UILabel!
    
    var slots : [UIImageView] = []
    var currSlot: Int = 0
    let passArr:[[UIImage]] = passwordArray.reversed()
    var pass : [UIImage] = []
    var numFails: Int = 0
    
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
            
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!) (retest), emoji clicked, success")
        }
        else {
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!) (retest), emoji clicked, error")
        }
    }
    
    //backspace functionality
    @IBAction func backspace(_ sender: UIButton) {
        if currSlot > 0 {
            currSlot -= 1
            slots[currSlot].image = nil
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!) (retest), deleter char, success")
        }
        else {
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!) (retest), delete char, error")
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
                    textLabel.text = "Please try again"
                    self.numFails += 1
                    addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!) (retest), submit password attempt #\(numFails), error")
                    clear()
                }
            }
            if count == 6 {
                textLabel.text = "Correct!!!"
                addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!) (retest), submit password, success")
                clear()
                viewDidLoad()
            }
        }
        else {
            self.numFails += 1
            textLabel.text = "Place 6 emojis"
            addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!) (retest), submit password attempt #\(numFails), error")
        }
    }
    
    //next/ skip round buttong
    @IBAction func skipRound(_ sender: UIButton) {
        addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!) (retest), skip round, failed")
        viewDidLoad()
    }
    
    //what gets shown on the screen when it is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pass = []
        slots = []
        
        slots.append(firstSlot)
        slots.append(secondSlot)
        slots.append(thirdSlot)
        slots.append(fourthSlot)
        slots.append(fifthSlot)
        slots.append(sixthSlot)
        
        iter = iter + 1
        switch iter {
        case 1:
            pass = passArr[0]
            systemLabel.text = "Bank Account"
            systemLabel.textColor = UIColor.green
            
        case 2:
            pass = passArr[1]
            systemLabel.text = "Email"
            systemLabel.textColor = UIColor.red
        case 3:
            pass = passArr[2]
            systemLabel.text = "Facebook"
            systemLabel.textColor = UIColor.blue
        case 4:
            systemLabel.text = "Simulation Complete."
            systemLabel.textColor = UIColor.black
            addToLog(message: writeTimeAndDate() + ", " + UID + ", general, simulation complete, success")
        default:
            pass = passwordArray[0]
        }
        
        
        
    }
}
