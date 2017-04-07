//
//  ViewController.swift
//  EmojiPassword
//
//  Created by Mat Schmid on 2017-03-08.
//  Copyright © 2017 Mat Schmid. All rights reserved.
//

// This file contains everything related to the initial loading screen.

import UIKit

//these two extensions needed for logging to an existing file.
extension String {
    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}

//init globals
var start = true
let UID = "User" + String(format: "%03d", arc4random_uniform(100))
var passwordArray : [[UIImage]] = []
var iteration = 0

class ViewController: UIViewController {
    //all outlets
    @IBOutlet weak var first: UIImageView!
    @IBOutlet weak var second: UIImageView!
    @IBOutlet weak var third: UIImageView!
    @IBOutlet weak var fourth: UIImageView!
    @IBOutlet weak var fifth: UIImageView!
    @IBOutlet weak var sixth: UIImageView!

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var systemLabel: UILabel!
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var retest: UIButton!
    
    var timeOutput : String = ""
    var generateCount = 0
    var password : [UIImage] = []
    
    //what gets placed to the screen when the page gets loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true
        retest.isHidden = true
        
        iteration = iteration + 1
        
        switch iteration {
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
            generateButton.isHidden = true
            nextButton.isHidden = true
            retest.isHidden = false
            textLabel.isHidden = true
            systemLabel.text = ""
            lbl.isHidden = true
            
            first.isHidden = true
            second.isHidden = true
            third.isHidden = true
            fourth.isHidden = true
            fifth.isHidden = true
            sixth.isHidden = true
            
        }
        
        if start {
            createWriteDir()
            start = false
        }
    }
    
    //creates log file
    func createWriteDir(){
        let fileName = "logData"
        let documentDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDir.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        print("File Path: \(fileURL.path)")
        
        let tableTitles = "Time, UserID, System, Action, Event\n"
        do {
            try tableTitles.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError{
            print("Failed to write log")
            print(error)
        }
    }
    
    //append to existing log file
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
    
    //get time and date - used in logging
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
    
    //initializes all the emojis
    func loadEmojis() -> [UIImage]{
        var emojis : [UIImage] = []

        emojis.append(UIImage(named: "1hunna")!)
        emojis.append(UIImage(named: "BasketBall")!)
        emojis.append(UIImage(named: "Bomb")!)
        emojis.append(UIImage(named: "Burger")!)
        emojis.append(UIImage(named: "Chilli")!)
        emojis.append(UIImage(named: "Devil")!)
        emojis.append(UIImage(named: "Dolphin")!)
        emojis.append(UIImage(named: "Eggplant")!)
        emojis.append(UIImage(named: "FireEmoji")!)
        emojis.append(UIImage(named: "Ghost")!)
        emojis.append(UIImage(named: "Harambe")!)
        emojis.append(UIImage(named: "Heart")!)
        emojis.append(UIImage(named: "Lifting")!)
        emojis.append(UIImage(named: "LightBulb")!)
        emojis.append(UIImage(named: "Lion")!)
        emojis.append(UIImage(named: "Moist")!)
        emojis.append(UIImage(named: "Money")!)
        emojis.append(UIImage(named: "Motorcycle")!)
        emojis.append(UIImage(named: "Peach")!)
        emojis.append(UIImage(named: "Pizza")!)
        emojis.append(UIImage(named: "Poop")!)
        emojis.append(UIImage(named: "RelationshipGoals")!)
        emojis.append(UIImage(named: "Santa")!)
        emojis.append(UIImage(named: "Snake")!)
        emojis.append(UIImage(named: "Snowborder")!)
        emojis.append(UIImage(named: "SoccerBall")!)
        emojis.append(UIImage(named: "SpaceInvader")!)
        emojis.append(UIImage(named: "Sunglasses")!)
        emojis.append(UIImage(named: "Unicorn")!)
        emojis.append(UIImage(named: "Watermelone")!)
        
        return emojis
    }
    
    //randomly selects 6 emojis from the pool of 30
    @IBAction func generate() {
    
        var emojis = loadEmojis()
        generateCount += 1
        let indexFirst = Int(arc4random_uniform(UInt32(emojis.count)))
        first.image = emojis[indexFirst]
        
        let indexSecond = Int(arc4random_uniform(UInt32(emojis.count)))
        second.image = emojis[indexSecond]
        
        let indexThird = Int(arc4random_uniform(UInt32(emojis.count)))
        third.image = emojis[indexThird]
        
        let indexFourth = Int(arc4random_uniform(UInt32(emojis.count)))
        fourth.image = emojis[indexFourth]
        
        let indexFifth = Int(arc4random_uniform(UInt32(emojis.count)))
        fifth.image = emojis[indexFifth]
        
        let indexSixth = Int(arc4random_uniform(UInt32(emojis.count)))
        sixth.image = emojis[indexSixth]
        
        addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), generate n.\(generateCount), success")
        nextButton.isHidden = false
    }
    
    //"Save Password" log
    @IBAction func nextScreen(_ sender: UIButton) {
        addToLog(message: writeTimeAndDate() + ", " + UID + ", \(systemLabel.text!), save, success")
    }
    
    //"Retest button" log
    @IBAction func retest(_ sender: UIButton) {
        addToLog(message: writeTimeAndDate() + ", " + UID + ", general, retest button clicked, success")
    }
    
    //Send relevant info over to the second view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.password.append(first.image!)
        self.password.append(second.image!)
        self.password.append(third.image!)
        self.password.append(fourth.image!)
        self.password.append(fifth.image!)
        self.password.append(sixth.image!)
        
        passwordArray.append(password)
        
        if segue.identifier == "goToVC"{
            if let destination = segue.destination as? SecondViewController {
                destination.pass = self.password
            }
        }
    }
    
    
}

