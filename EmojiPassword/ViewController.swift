//
//  ViewController.swift
//  EmojiPassword
//
//  Created by Mat Schmid on 2017-03-08.
//  Copyright © 2017 Mat Schmid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var first: UIImageView!
    @IBOutlet weak var second: UIImageView!
    @IBOutlet weak var third: UIImageView!
    @IBOutlet weak var fourth: UIImageView!
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var password : [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true
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

        let indexFirst = Int(arc4random_uniform(UInt32(emojis.count)))
        first.image = emojis[indexFirst]
        
        let indexSecond = Int(arc4random_uniform(UInt32(emojis.count)))
        second.image = emojis[indexSecond]
        
        let indexThird = Int(arc4random_uniform(UInt32(emojis.count)))
        third.image = emojis[indexThird]
        
        let indexFourth = Int(arc4random_uniform(UInt32(emojis.count)))
        fourth.image = emojis[indexFourth]
        
        nextButton.isHidden = false


    }
    
    @IBAction func nextScreen(_ sender: UIButton) {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.password.append(first.image!)
        self.password.append(second.image!)
        self.password.append(third.image!)
        self.password.append(fourth.image!)
        
        if segue.identifier == "goToVC"{
            if let destination = segue.destination as? SecondViewController {
                destination.pass = self.password
            }
        }
    }
    
    
}

