//
//  ViewController.swift
//  BullsEye
//
//  Created by liushun on 15/11/23.
//  Copyright © 2015年 liushun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    // 保存一下slider的value
    var currentValue = 50
    var targetValue = 0
    var score = 0
    var round = 0
    
    // HitMe按钮
    @IBAction func showAlert(sender: UIButton) {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        score += points
        
        var title = ""
        if difference == 0{
            title = "Perfect"
        }else if difference < 5{
            title = "You almost had it"
            if difference == 1{
                points += 50
            }
        }else if difference < 10{
            title = "Pretty good!"
        }else{
            title = "Not even close..."
        }
        score += points
   
        
        //let message = "The value of the slider is: \(currentValue) \nThe target value is: \(targetValue) \n The difference is \(difference)"
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: {
            _ in
            self.startNewRound()
            self.updateLables()
        })
        
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    // slider移动
    @IBAction func sliderMoved(sender: UISlider) {
        currentValue = lroundf(sender.value)
        print("The value of the slider is now: \(sender.value)")
    }
    
    @IBAction func refresh(sender: AnyObject) {
        startNewRound()
        print("a new round begin")
    }
    // 新的一轮
    func startNewRound(){
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    // 给targetLabel赋值
    func updateLables(){
        print("=======@\(targetValue)")
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    // 重新开始
    func startNewGame(){
        score = 0
        round = 0
        startNewRound()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //currentValue = lroundf(slider.value)
        //targetValue = 1 + Int(arc4random_uniform(100))
        //print(targetValue)
        
        startNewGame()
        updateLables()
        print("========\(targetValue)")
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

