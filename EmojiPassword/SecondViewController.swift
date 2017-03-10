//
//  SecondViewController.swift
//  EmojiPassword
//
//  Created by Mat Schmid on 2017-03-08.
//  Copyright © 2017 Mat Schmid. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var firstSlot: UIImageView!
    @IBOutlet weak var secondSlot: UIImageView!
    @IBOutlet weak var thirdSlot: UIImageView!
    @IBOutlet weak var fourthSlot: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    
    var slots : [UIImageView] = []
    var currSlot: Int = 0
    var pass : [UIImage] = []
    var numFails: Int = 0
    

    
    @IBAction func emojiClicked(_ sender: UIButton) {
        if currSlot < 4 {
            slots[currSlot].image = sender.currentImage
            currSlot += 1
        }
    }
    
    @IBAction func backspace(_ sender: UIButton) {
        if currSlot > 0 {
            currSlot -= 1
            slots[currSlot].image = nil
        }
    }
    
    func clear() {
        for i in slots{
            i.image = nil
        }
        currSlot = 0
    }
    
    @IBAction func checkPassword(_ sender: UIButton) {
        var count : Int = 0
        if currSlot == 4 {
            for i in 0..<4{
                if pass[i] == slots[i].image{
                    count += 1
                }
                else{
                    textLabel.text = "Please try again"
                    clear()
                }
            }
            if count == 4 {
                textLabel.text = "Correct!!"
                for i in slots{
                    i.image = #imageLiteral(resourceName: "smile-glasses")
                }
            }
        }
        else {
            self.numFails += 1
            textLabel.text = "Place 4 emojis"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slots.append(firstSlot)
        slots.append(secondSlot)
        slots.append(thirdSlot)
        slots.append(fourthSlot)
    }
}
