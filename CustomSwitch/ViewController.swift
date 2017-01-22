//
//  ViewController.swift
//  CustomSwitch
//
//  Created by Ivan Kovacevic on 15/12/2016.
//  Copyright © 2016 Ivan Kovacevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiswitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //
        let switch1 = CustomSwitch(frame: CGRect(x: 50, y: 50, width: 55, height: 25))
        
        switch1.isOn = false
        switch1.onTintColor = UIColor(red: 127/255, green: 202/255, blue: 196/255, alpha: 1)
        switch1.offTintColor = UIColor.lightGray
        switch1.cornerRadius = 0.5
        switch1.thumbCornerRadius = 0.5
        switch1.thumbSize = CGSize(width: 30, height: 30)
        switch1.thumbTintColor = UIColor(red: 1/255, green: 150/255, blue: 137/255, alpha: 1)
        switch1.padding = 0
        switch1.animationDuration = 0.25
        
        self.view.addSubview(switch1)
        
        
        //
        let switch2 = CustomSwitch(frame: CGRect(x: 50, y: 100, width: 50, height: 30))
        
        switch2.onTintColor = UIColor.orange
        switch2.offTintColor = UIColor.darkGray
        switch2.cornerRadius = 0.1
        switch2.thumbCornerRadius = 0.1
        switch2.thumbTintColor = UIColor.white
        
        self.view.addSubview(switch2)
        
        
        //
        let switch3 = CustomSwitch(frame: CGRect(x: 50, y: 150, width: 60, height: 30))
        
        switch3.onTintColor = UIColor.black
        switch3.offTintColor = UIColor.black
        switch3.cornerRadius = 0.5
        switch3.thumbCornerRadius = 0.5
        switch3.thumbSize = CGSize(width: 25, height: 25)
        switch3.thumbTintColor = UIColor.white
        switch3.padding = 2
        switch3.animationDuration = 0.6
        switch3.thumbShaddowOppacity = 0
        
        self.view.addSubview(switch3)
        
        
        //
        let switch4 = CustomSwitch(frame: CGRect(x: 50, y: 200, width: 80, height: 30))
        
        switch4.onTintColor = UIColor(red: 24/255, green: 162/255, blue: 23/255, alpha: 1)
        switch4.offTintColor = UIColor(red: 153/255, green: 71/255, blue: 58/255, alpha: 1)
        switch4.cornerRadius = 0.05
        switch4.thumbCornerRadius = 0.05
        switch4.thumbSize = CGSize(width: 40, height: 25)
        switch4.thumbTintColor = UIColor.white
        switch4.padding = 3
        switch4.animationDuration = 0.75
        switch4.thumbShaddowRadius = 2
        switch4.thumbShaddowOppacity = 0.7
        //switch4.areLabelsShown = true
        switch4.onImage = #imageLiteral(resourceName: "chackamark")
        switch4.offImage = #imageLiteral(resourceName: "delete")
        
        self.view.addSubview(switch4)
        
        
        //
        let switch5 = CustomSwitch(frame: CGRect(x: 50, y: 250, width: 90, height: 30))
        
        switch5.onTintColor = UIColor(red: 8/255, green: 118/255, blue: 160/255, alpha: 1)
        switch5.offTintColor = UIColor(red: 73/255, green: 73/255, blue: 73/255, alpha: 1)
        switch5.cornerRadius = 0
        switch5.thumbCornerRadius = 0
        switch5.thumbSize = CGSize(width: 40, height: 28)
        switch5.thumbTintColor = UIColor.white
        switch5.padding = 1
        switch5.animationDuration = 0
        switch5.thumbShaddowRadius = 0
        switch5.thumbShaddowOppacity = 0
        
        self.view.addSubview(switch5)
        
        
        //
        let switch6 = CustomSwitch(frame: CGRect(x: 50, y: 300, width: 60, height: 28))
        
        switch6.onTintColor = UIColor(red: 30/255, green: 38/255, blue: 105/255, alpha: 1)
        switch6.offTintColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        switch6.cornerRadius = 0.5
        switch6.thumbCornerRadius = 0.15
        switch6.thumbSize = CGSize(width: 35, height: 32)
        switch6.thumbTintColor = UIColor(red: 41/255, green: 52/255, blue: 151/255, alpha: 1) // 41	52	151
        switch6.padding = -2
        
        self.view.addSubview(switch6)
        
        //
        let switch7 = CustomSwitch(frame: CGRect(x: 50, y: 350, width: 55, height: 25))
        
        switch7.isOn = false
        switch7.onTintColor = UIColor.lightGray
        switch7.offTintColor = UIColor.darkGray
        switch7.cornerRadius = 0.5
        switch7.thumbCornerRadius = 0.5
        switch7.thumbSize = CGSize(width: 30, height: 30)
        switch7.thumbTintColor = /*UIColor.clear*/UIColor(red: 1/255, green: 150/255, blue: 137/255, alpha: 1)
        switch7.padding = 0
        switch7.animationDuration = 0.7
        //switch7.thumbImage = #imageLiteral(resourceName: "CustomSwitchImg.png")
        switch7.onImage = #imageLiteral(resourceName: "checkamark")
        switch7.offImage = #imageLiteral(resourceName: "delete")
        self.view.addSubview(switch7)
    }
}

