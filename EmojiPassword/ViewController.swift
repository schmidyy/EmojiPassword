//
//  ViewController.swift
//  EmojiPassword
//
//  Created by Mat Schmid on 2017-03-08.
//  Copyright © 2017 Mat Schmid. All rights reserved.
//

import UIKit

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

var start = true
let UID = "User" + String(format: "%03d", arc4random_uniform(100))
var passwordArray : [[UIImage]] = []
var iteration = 0

class ViewController: UIViewController {
    
    @IBOutlet weak var first: UIImageView!
    @IBOutlet weak var second: UIImageView!
    @IBOutlet weak var third: UIImageView!
    @IBOutlet weak var fourth: UIImageView!
    @IBOutlet weak var fifth: UIImageView!
    @IBOutlet weak var sixth: UIImageView!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var sixthLabel: UILabel!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var systemLabel: UILabel!
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var retest: UIButton!
    
    var timeOutput : String = ""
    var generateCount = 0
    var password : [UIImage] = []
    
    
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
        
        print(UID)
        
        firstLabel.text = ""
        secondLabel.text = ""
        thirdLabel.text = ""
        fourthLabel.text = ""
        fifthLabel.text = ""
        sixthLabel.text = ""
    }
    
    func createWriteDir(){
        let fileName = "logData"
        let documentDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = documentDir.appendingPathComponent(fileName).appendingPathExtension("txt")
        
        print("File Path: \(fileURL.path)")
        
        let tableTitles = "time, UserID, Action, Event\n"
        do {
            try tableTitles.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError{
            print("Failed to write log")
            print(error)
        }
    }
    
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
    
    func loadEmojis() -> [UIImage]{
        var emojis : [UIImage] = []
        emojis.append(UIImage(named: "smile-glasses")!)
        emojis.append(UIImage(named: "tired")!)
        emojis.append(UIImage(named: "hmm")!)
        emojis.append(UIImage(named: "heart-eyes")!)
        emojis.append(UIImage(named: "laughing")!)
        emojis.append(UIImage(named: "smile-halo")!)
        emojis.append(UIImage(named: "surprised")!)
        emojis.append(UIImage(named: "tired")!)
        emojis.append(UIImage(named: "tongue")!)
        emojis.append(UIImage(named: "alien")!)
        emojis.append(UIImage(named: "eggplant")!)
        emojis.append(UIImage(named: "ghost")!)
        emojis.append(UIImage(named: "heart")!)
        emojis.append(UIImage(named: "hotdog")!)
        emojis.append(UIImage(named: "monkey")!)
        emojis.append(UIImage(named: "poop")!)
        emojis.append(UIImage(named: "snake")!)
        emojis.append(UIImage(named: "peach")!)
        emojis.append(UIImage(named: "chilli")!)
        emojis.append(UIImage(named: "sad")!)
        emojis.append(UIImage(named: "uhoh")!)
        emojis.append(UIImage(named: "dizzy")!)
        emojis.append(UIImage(named: "neutral")!)
        emojis.append(UIImage(named: "secret")!)
        emojis.append(UIImage(named: "bomb")!)
        emojis.append(UIImage(named: "fire")!)
        emojis.append(UIImage(named: "sun")!)
        emojis.append(UIImage(named: "peace")!)
        emojis.append(UIImage(named: "money")!)
        emojis.append(UIImage(named: "mad")!)
        
        return emojis
    }
    
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
        
        addToLog(message: writeTimeAndDate() + ", " + UID + ", generate n.\(generateCount), success")
        nextButton.isHidden = false
    }
    
    @IBAction func nextScreen(_ sender: UIButton) {
        addToLog(message: writeTimeAndDate() + ", " + UID + ", save, success")
    }
    
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

