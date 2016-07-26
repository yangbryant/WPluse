//
//  ViewController.swift
//  WPluseDemo
//
//  Created by everyoo.com on 16/7/26.
//  Copyright © 2016年 goingeo. All rights reserved.
//

import UIKit
import WPluse

class ViewController: UIViewController, WPluseDurationDelegate {

    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.orangeColor()
        WPluse.sharedView().delegate = self
        
        button = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(110, 180, 100, 100)
        button.backgroundColor = UIColor.blackColor()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = button.frame.size.width/2
        button.setTitle("启动", forState: UIControlState.Normal)
        button.setTitle("停止", forState: UIControlState.Selected)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(self.btnTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func btnTapped(sender: UIButton) {
        if sender.selected == false {
            WPluse.showWithDelegate(sender, duration: 10.0)
        }
        else {
            WPluse.dismiss()
        }
        sender.selected = !sender.selected
    }
    
    func wPluseDurationFinished() {
        button.selected = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

